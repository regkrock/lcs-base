Class {
	#name : #GtPharoBehaviorDefinitionCoderElement,
	#superclass : #BrExpander,
	#instVars : [
		'modificationIndicator',
		'previewButton',
		'behaviorCoderViewModel',
		'cancelButton'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> addDefinitionEditorShortcutsTo: arg1 [
	| tmp2 tmp9 |
	tmp2 := BlShortcutWithAction new.
	tmp2 combination: BlKeyCombination arrowUp.
	arg1
		addShortcut: (tmp2
				action: [ :arg2 | 
					| tmp3 tmp5 |
					tmp5 := tmp3 := arg2 currentTarget deepestFocusedChild.
					tmp5
						ifNotNil: [ | tmp7 |
							tmp7 := BlFocusFinder new.
							tmp7
								up;
								root: arg2 currentTarget;
								referenceElement: tmp3;
								nextFocusDo: [ :arg3 | arg3 requestFocus ] ] ]).
	tmp9 := BlShortcutWithAction new.
	tmp9 combination: BlKeyCombination arrowDown.
	arg1
		addShortcut: (tmp9
				action: [ :arg4 | 
					| tmp10 tmp12 |
					tmp12 := tmp10 := arg4 currentTarget deepestFocusedChild.
					tmp12
						ifNotNil: [ | tmp14 |
							tmp14 := BlFocusFinder new.
							tmp14
								down;
								root: arg4 currentTarget;
								referenceElement: tmp10;
								nextFocusDo: [ :arg5 | arg5 requestFocus ] ] ])
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildDefinitionEditor [
	self coderViewModel coder behavior isObsolete ifTrue: [ ^ BlElement new ].
	^ (self coderViewModel coder behavior isTrait
		ifTrue: [ GtTraitUpdateForm onTrait: self coderViewModel coder behavior ]
		ifFalse: [ GtClassUpdateForm onClass: self coderViewModel coder behavior ])
		onElementCreated: [ :arg1 | 
			(arg1 allChildrenBreadthFirstSelect: [ :arg2 | arg2 isKindOf: BrTagger ])
				do: [ :arg3 | arg3 parent hMatchParent ] ]
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildDefinitionReader [
	| tmp1 tmp2 tmp3 tmp5 |
	tmp5 := BrHorizontalPane new.
	tmp5 hMatchParent.
	tmp1 := tmp5 vFitContent.
	tmp2 := self readers.
	tmp3 := tmp2 first.
	tmp3
		aptitude: [ self readonlyLabelLook
				+ (BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: self contextMenuItemsForSuperclass ]) ];
		margin: self buttonMargin.
	tmp1
		addChildren: {self buildSectionLabel: tmp3 title.
				tmp3 asElement}.
	tmp2 size > 1
		ifTrue: [ | tmp7 |
			tmp7 := tmp2 second.
			tmp7
				aptitude: [ self readonlyLabelLook ];
				margin: self buttonMargin.
			tmp1
				addChildren: {self buildSectionLabel: tmp2 second title.
						tmp7 asElement} ].
	^ tmp1
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildSectionLabel: arg1 [
	| tmp2 tmp4 |
	tmp2 := BrLabel new.
	tmp4 := BrGlamorousLabelAptitude new glamorousRegularFontAndSize.
	tmp4 foreground: Color gray.
	tmp2
		aptitude: (tmp4 fontSize: 12);
		text: arg1 , ':';
		focusability: BlFocusability none;
		margin: (BlInsets
					top: 5
					right: 5
					bottom: 0
					left: 5).
	^ tmp2 constraintsDo: [ :arg2 | arg2 grid horizontal alignLeft ]
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> buttonMargin [
	^ BlInsets
		top: 3
		left: 0
		bottom: 3
		right: 5
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> coderViewModel [
	^ behaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> coderViewModel: arg1 [
	behaviorCoderViewModel := arg1.
	behaviorCoderViewModel weak
		when: GtCoderClassChanged
		send: #updateDefinition
		to: self.
	self initializeElements
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :arg1 | arg1 phlow spawnObject: arg1 text asString asClass gtReferences ]}
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> editableLabelLook [
	| tmp2 |
	tmp2 := BrGlamorousEditableLabelAptitude new.
	tmp2
		glamorousCodeFont;
		defaultForeground: Color black.
	^ tmp2 fontSize: 10
]

{ #category : #initialization }
GtPharoBehaviorDefinitionCoderElement >> initialize [
	super initialize.
	self
		aptitude: GtCoderExpanderAptitude;
		hMatchParent;
		vFitContent;
		when: BlClickEvent
			do: [ :arg1 | 
					arg1 consumed: true.
					self expand ].
	modificationIndicator := self newModificationIndicator.
	self addChild: modificationIndicator
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> initializeElements [
	self
		header: [ self buildDefinitionReader ];
		content: [ self buildDefinitionEditor ]
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> newModificationIndicator [
	| tmp2 |
	tmp2 := BlElement new.
	tmp2
		constraintsDo: [ :arg1 | 
			arg1 ignoreByLayout.
			arg1 ignored horizontal alignLeft.
			arg1 horizontal exact: 5.
			arg1 vertical matchParent.
			arg1 margin: (BlInsets left: 8) ];
		preventMeAndChildrenMouseEvents;
		background: self theme status changesBackgroundColor;
		id: GtTextualCoderModificationIndicatorId;
		visibility: BlVisibility gone.
	^ tmp2
		withAsyncPromiseDo: [ :arg2 | 
			arg2
				whenSuccess: [ :arg3 :arg4 | 
					arg3
						visibility: (arg4 ifTrue: [ BlVisibility visible ] ifFalse: [ BlVisibility gone ]) ] ]
]

{ #category : #'private - accessing' }
GtPharoBehaviorDefinitionCoderElement >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	^ behaviorCoderViewModel coder definition readers
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> readonlyLabelLook [
	| tmp2 tmp4 |
	tmp2 := BrGlamorousEditorAptitude new.
	tmp2
		glamorousCodeFont;
		fontSize: 10;
		foreground: Color black.
	tmp4 := BrStyleCommonAptitude new.
	tmp4
		default: [ :arg1 | 
			arg1
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				border: BlBorder empty ].
	tmp2
		add: (tmp4
				hovered: [ :arg2 | arg2 border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ]).
	^ tmp2 yourself
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> updateDefinition [
	self enqueueTask: (BlTaskAction new action: [ self initializeElements ])
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> updateModified [
	| tmp1 tmp2 |
	tmp1 := self coderViewModel coder difference hasDifference.
	modificationIndicator asyncPromise promise: tmp1.
	tmp2 := tmp1 ifTrue: [ BlVisibility visible ] ifFalse: [ BlVisibility gone ].
	previewButton visibility: tmp2.
	cancelButton visibility: tmp2
]
