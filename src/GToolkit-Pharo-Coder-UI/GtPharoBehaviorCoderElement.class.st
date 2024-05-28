Class {
	#name : #GtPharoBehaviorCoderElement,
	#superclass : #BlElement,
	#traits : 'TGtWithCoderToolbar',
	#classTraits : 'TGtWithCoderToolbar classTrait',
	#instVars : [
		'container',
		'contentPane',
		'contentTabs',
		'behaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnMethodProtocol: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := contentTabs viewModel tabs
			detect: [ :arg2 | arg2 widget label asString = 'Methods' ]
			ifNone: [ ^ self ].
	tmp1 isSelected
		ifFalse: [ tmp2 := [ tmp1 select ].
			self executeTask: tmp2 ].
	tmp3 := [ self
			filterWithMethodProtocol: arg1 methodProtocol name
			source: arg1 source ].
	self executeTask: tmp3
]

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnPackageUpdated: arg1 [
	self removeContentTabs
]

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnSelectMethod: arg1 [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := arg1 method.
	tmp2 := contentTabs viewModel tabs
			detect: [ :arg2 | arg2 widget label asString = 'Methods' ]
			ifNone: [ ^ self ].
	tmp2 isSelected
		ifFalse: [ tmp3 := [ tmp2 select ].
			self executeTask: tmp3 ].
	tmp4 := [ self selectAndScrollToMethod: tmp1 ].
	self executeTask: tmp4
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> actOnSlot: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := contentTabs viewModel tabs
			detect: [ :arg2 | arg2 widget label asString = 'Methods' ]
			ifNone: [ ^ self ].
	tmp1 isSelected
		ifFalse: [ tmp2 := [ tmp1 select ].
			self executeTask: tmp2 ].
	tmp3 := arg1 slot owningClass isMeta
			ifTrue: [ [ self filterWithClassSlot: arg1 slot name source: arg1 source ] ]
			ifFalse: [ arg1 slot isClassVariable
					ifTrue: [ [ self filterWithClassVariable: arg1 slot name source: arg1 source ] ]
					ifFalse: [ [ self filterWithSlot: arg1 slot name source: arg1 source ] ] ].
	self executeTask: tmp3
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> addFilters: arg1 [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :arg2 | arg2 isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :arg3 | arg3 streamingCodersViewModel additionalFilters: arg1 ]
		ifNone: [  ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> addOrReplaceFilter: arg1 [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :arg2 | arg2 isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :arg3 | 
			| tmp1 tmp2 tmp4 |
			tmp1 := arg3 streamingCodersViewModel.
			tmp4 := false.
			tmp2 := tmp1 additionalFilters
					collect: [ :arg4 | 
						arg4 class = arg1 class
							ifTrue: [ tmp4 := true.
								arg1 ]
							ifFalse: [ arg4 ] ].
			tmp4 ifFalse: [ tmp2 := tmp2 , {arg1} ].
			tmp1 additionalFilters: tmp2 ]
		ifNone: [  ]
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> behavior [
	<return: #Behavior>
	^ self coderViewModel coder behavior
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildClassHeader [
	| tmp1 tmp3 |
	tmp3 := BrHorizontalPane new.
	tmp3
		hMatchParent;
		alignCenterLeft.
	tmp1 := tmp3 vFitContent.
	tmp1
		addChild: (GtPharoBehaviorCoderNameElement new coderViewModel: behaviorCoderViewModel);
		addChild: self toolbarElement.
	^ tmp1
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildContentPane [
	contentPane := BlElement new.
	contentPane
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ];
		padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
		addChild: self makeLabel;
		addChild: self buildClassHeader;
		addChild: self buildDefinitionElement;
		addChild: self buildContentTabs.
	^ contentPane
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildContentTabs [
	<return: #BrTabGroup>
	| tmp2 |
	tmp2 := GtPhlowCompositeView new.
	tmp2 views: self classViewItems.
	contentTabs := tmp2 asElementDo: [ :arg1 | arg1 ].
	^ contentTabs
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildDefinitionElement [
	| tmp2 |
	tmp2 := GtPharoBehaviorDefinitionCoderElement new.
	tmp2 coderViewModel: behaviorCoderViewModel definitionCoderUIModel.
	^ tmp2 margin: (BlInsets top: 5 left: 5)
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> classCoder [
	^ behaviorCoderViewModel classCoder
]

{ #category : #private }
GtPharoBehaviorCoderElement >> classViewItems [
	| tmp1 tmp2 tmp3 tmp5 |
	tmp1 := behaviorCoderViewModel coder.
	tmp5 := GtPhlowViewsCollector new.
	tmp5
		fromObject: tmp1 theClass;
		from: tmp1 theClass class;
		to: Behavior.
	tmp2 := tmp5 pragmaName: #gtClassView.
	tmp3 := GtPhlowContext new.
	tmp3 optionAt: #behaviorCoder put: behaviorCoderViewModel.
	tmp2 context: tmp3.
	^ tmp2 collect
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderViewModel [
	^ behaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderViewModel: arg1 [
	self unsubscribeFromCoderViewModel.
	behaviorCoderViewModel := arg1.
	self
		subscribeToCoderViewModel;
		updateContent
]

{ #category : #private }
GtPharoBehaviorCoderElement >> executeTask: arg1 [
	BlUseAsyncFeatures
		ifEnabledDo: [ self enqueueTask: (BlTaskAction new action: arg1) ]
		otherwise: arg1
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithClassSlot: arg1 source: arg2 [
	self
		addFilters: {GtSearchClassSlotReferenceFilter
					forClass: arg2 selectedClass class
					andVariable: arg1}
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithClassVariable: arg1 source: arg2 [
	self
		addFilters: {GtSearchClassVariableReferenceFilter
					forClass: arg2 selectedClass
					andVariable: arg1}
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> filterWithMethodProtocol: arg1 source: arg2 [
	self addOrReplaceFilter: (GtSearchMethodCategoryFilter forCategory: arg1)
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithSlot: arg1 source: arg2 [
	self
		addFilters: {GtSearchInstanceSlotReferenceFilter
					forClass: arg2 selectedClass
					andVariable: arg1}
]

{ #category : #initialization }
GtPharoBehaviorCoderElement >> initialize [
	super initialize.
	self
		initializeToolbarElement;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ];
		when: BlClickEvent do: [ self requestFocus ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> makeLabel [
	| tmp2 tmp4 |
	tmp2 := BrLabel new.
	tmp4 := BrGlamorousLabelAptitude new glamorousRegularFontAndSize.
	tmp4 foreground: Color gray.
	tmp2
		aptitude: (tmp4 fontSize: 12);
		text: 'Class'.
	^ tmp2 padding: (BlInsets left: 5)
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> removeContentTabs [
	contentTabs
		ifNotNil: [ contentPane removeChild: contentTabs.
			contentTabs := nil ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> selectAndScrollToMethod: arg1 [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :arg2 | arg2 isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :arg3 | 
			| tmp2 |
			tmp2 := arg3 streamingCodersViewModel.
			tmp2
				expandAndFocusCompiledMethod: arg1;
				scrollToCompiledMethod: arg1 ]
		ifNone: [  ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> streamingMethodCodersElement [
	^ contentTabs content
		allChildrenBreadthFirstDetect: [ :arg1 | arg1 isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: #yourself
		ifNone: [  ]
]

{ #category : #subscriptions }
GtPharoBehaviorCoderElement >> subscribeToCoderViewModel [
	| tmp2 |
	tmp2 := behaviorCoderViewModel coder weak.
	tmp2
		when: GtCoderPackageUpdatedAnnouncement
			send: #actOnPackageUpdated:
			to: self;
		when: GtClassCoderMethodNavigationAnnouncement
			send: #actOnSelectMethod:
			to: self;
		when: GtClassCoderMethodProtocolNavigationAnnouncement
			send: #actOnMethodProtocol:
			to: self;
		when: GtClassCoderSlotNavigationAnnouncement
			send: #actOnSlot:
			to: self
]

{ #category : #subscriptions }
GtPharoBehaviorCoderElement >> unsubscribeFromCoderViewModel [
	| tmp1 |
	(tmp1 := behaviorCoderViewModel) ifNotNil: [ tmp1 unsubscribe: self ]
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> updateContent [
	| tmp1 |
	(tmp1 := container) ifNotNil: [ tmp1 removeFromParent ].
	container := self buildContentPane.
	self addChildFirst: container
]
