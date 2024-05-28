Class {
	#name : #GtPharoMethodsCoderElement,
	#superclass : #BlElement,
	#instVars : [
		'methodsCoderUIModel',
		'listElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #converting }
GtPharoMethodsCoderElement >> asVerticallyResizableDo: arg1 [
	
]

{ #category : #ui }
GtPharoMethodsCoderElement >> buildElement [
	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :arg1 | 
				arg1 horizontal matchParent.
				arg1 vertical matchParent ];
		buildFilter;
		addChild: self listElement as: #codersList
]

{ #category : #ui }
GtPharoMethodsCoderElement >> buildFilter [
	| tmp1 tmp2 tmp4 |
	methodsCoderUIModel coder canFilter ifFalse: [ ^ self ].
	tmp2 := methodsCoderUIModel coder filterDescriptors.
	tmp2 isEmpty ifTrue: [ ^ self ].
	tmp4 := GtFiltersElement new.
	tmp4
		padding: (BlInsets all: 2);
		descriptors: tmp2.
	tmp1 := tmp4 yourself.
	tmp1 when: GtFiltersChangedEvent do: [ :arg1 | self updateCodersFilters: arg1 ].
	methodsCoderUIModel coder announcer weak
		when: GtCodersFiltersChanged
		send: #updateDisplayedFilters:
		to: self.
	self addChild: tmp1 as: #filter
]

{ #category : #accessing }
GtPharoMethodsCoderElement >> codersUIModel [
	^ methodsCoderUIModel
]

{ #category : #accessing }
GtPharoMethodsCoderElement >> codersUIModel: arg1 [
	methodsCoderUIModel := arg1.
	self buildElement.
	methodsCoderUIModel coder announcer weak
		when: GtCodersCoderAdded , GtCodersCoderRemoved , GtCodersCodersChanged
		send: #updateList
		to: self
]

{ #category : #ui }
GtPharoMethodsCoderElement >> filterElement [
	^ self childWithId: #filter
]

{ #category : #'updating ui' }
GtPharoMethodsCoderElement >> filterWithMethodProtocol: arg1 source: arg2 [
	| tmp1 |
	tmp1 := GtSearchMethodCategoryFilter forCategory: arg1.
	methodsCoderUIModel coder setFilters: {tmp1} source: arg2
]

{ #category : #ui }
GtPharoMethodsCoderElement >> listElement [
	| tmp2 |
	listElement ifNotNil: [ ^ listElement ].
	tmp2 := BrSimpleList new.
	tmp2
		matchParent;
		beInSeparateCompositionLayer;
		itemType: [ :arg1 :arg2 | arg2 elementClass ];
		itemId: [ :arg3 | arg3 coder id ];
		itemStencil: [ :arg4 | arg4 new ];
		itemDataBinder: [ :arg5 :arg6 | arg5 coderViewModel: arg6 ];
		items: methodsCoderUIModel coderUIModels.
	listElement := tmp2 yourself.
	^ listElement
]

{ #category : #'private - event handling' }
GtPharoMethodsCoderElement >> scrollToEvent: arg1 [
	| tmp1 tmp2 |
	tmp1 := arg1 sourceCoder.
	tmp2 := methodsCoderUIModel coder coders identityIndexOf: tmp1.
	tmp2 > 0
		ifTrue: [ (self childNamed: #codersList) aptitude listElement scrollToPosition: tmp2 ]
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateCodersFilters: arg1 [
	| tmp1 |
	tmp1 := OrderedCollection new.
	arg1 filterElement
		filtersDo: [ :arg2 :arg3 | tmp1 add: (arg2 newFilterWithValue: arg3) ].
	^ methodsCoderUIModel coder setFilters: tmp1 source: self
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateDisplayedFilters: arg1 [
	arg1 source = self ifTrue: [ ^ self ].
	self
		childWithId: #filter
		ifFound: [ :arg2 | 
			arg2
				buildFilters: [ methodsCoderUIModel coder additionalFilters
						do: [ :arg3 | 
							| tmp1 tmp2 tmp4 |
							tmp4 := tmp2 := arg3 class filterDescriptorFor: methodsCoderUIModel coder.
							tmp4
								ifNotNil: [ tmp1 := tmp2 valueIsRequired ifTrue: [ arg3 filterValueString ].
									arg2 addFilterForDescriptor: tmp2 andValue: tmp1 ] ] ] ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateList [
	methodsCoderUIModel ifNil: [ ^ self ].
	methodsCoderUIModel updateCoderUIModels.
	self listElement items: methodsCoderUIModel coderUIModels
]
