Class {
	#name : #LcsBaseSlot,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'parent',
		'domainClass',
		'properties'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsBaseSlot >> addSlotType: aClass [
	self assert: aClass isClass.
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #validations }
LcsBaseSlot >> addValidationCondition: aValidationCondition [
	self validationConditions addValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlot >> addValidationCondition: aBlock description: aString [
	self validationConditions addValidationCondition: aBlock description: aString
]

{ #category : #configuration }
LcsBaseSlot >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : #'slot model' }
LcsBaseSlot >> domainClass [
	^ domainClass ifNil: [ domainClass := self parent ifNotNil: [ :parnt | parnt domainClass ] ]
]

{ #category : #'slot model' }
LcsBaseSlot >> domainClass: aDomainClass [
	domainClass := aDomainClass
]

{ #category : #magritte }
LcsBaseSlot >> domainClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Class';
		priority: 12;
		accessor: #'domainClass';
		beReadOnly;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : #initialize }
LcsBaseSlot >> initialize [
	super initialize.
	self properties: OrderedDictionary new.
	self slotName: nil.
	self initializeSlotTypes.
	self validationConditions: (LcsValidationConditions newOn: self).
	self priority: 50
]

{ #category : #initialize }
LcsBaseSlot >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #testing }
LcsBaseSlot >> isChangedProperty: aPropertyName value: aValue [
	(self respondsTo: aPropertyName asSymbol) ifFalse: [ ^ true ].
	^ ((self perform: aPropertyName asSymbol) = aValue) not
]

{ #category : #'slot model' }
LcsBaseSlot >> label [
	^self labelForSelector: self slotName
]

{ #category : #accessing }
LcsBaseSlot >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseSlot >> parent: anObject [
	parent := anObject
]

{ #category : #properties }
LcsBaseSlot >> priority [
	^ self properties at: 'priority' ifAbsent: [ ]
]

{ #category : #properties }
LcsBaseSlot >> priority: anObject [
	self properties at: 'priority' put: anObject
]

{ #category : #magritte }
LcsBaseSlot >> priorityDescription [
	<magritteDescription>
	^ MANumberDescription new
		label: 'Priority';
		priority: 10;
		accessor: #'priority';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired

]

{ #category : #accessing }
LcsBaseSlot >> properties [
	^ properties
]

{ #category : #accessing }
LcsBaseSlot >> properties: anObject [
	properties := anObject
]

{ #category : #validations }
LcsBaseSlot >> removeValidationCondition: aValidationCondition [
	self validationConditions removeValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlot >> removeValidationConditionWithDescription: aString [
	self validationConditions removeValidationConditionWithDescription: aString
]

{ #category : #defaults }
LcsBaseSlot >> slotClass [
	^ self slotTypes any
]

{ #category : #magritte }
LcsBaseSlot >> slotClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Definition Class';
		priority: 1;
		accessor: #'className';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beReadOnly

]

{ #category : #properties }
LcsBaseSlot >> slotName [
	^ self properties at: 'slotName' ifAbsent: [ ]
]

{ #category : #properties }
LcsBaseSlot >> slotName: anObject [
	self properties at: 'slotName' put: anObject
]

{ #category : #magritte }
LcsBaseSlot >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self domainClass ifNil: [ #() ] ifNotNil: [ :c | c allInstVarNames ].
	^ GtMATextDescription new
		label: 'Slot Name';
		priority: 1;
		accessor: #'slotName';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beReadOnly;
		beRequired

]

{ #category : #'gt views' }
LcsBaseSlot >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: (
			eachClass isClass 
				ifTrue: [ eachClass name displayString ] 
				ifFalse: [ eachClass printString ])  ] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : #properties }
LcsBaseSlot >> slotTypes [
	^ self properties at: 'slotTypes' ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #properties }
LcsBaseSlot >> slotTypes: anObject [
	self properties at: 'slotTypes' put: anObject
]

{ #category : #magritte }
LcsBaseSlot >> slotTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slot Types';
		priority: 6;
		accessor: #slotTypes;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		beReadOnly

]

{ #category : #'slot model' }
LcsBaseSlot >> slotVarPut: anObject in: aDomainObject [
	^ LcsError signal: 'Attempt to update a read only slot'
]

{ #category : #magritte }
LcsBaseSlot >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
	^ [ :aMemento :aDescription :aForm | 
	| aTagger aTaggerAptitude |
	aTagger := BrTagger new hFitContentLimited.
	aForm hMatchParent.
	aTagger
		padding: (BlInsets top: -2 bottom: 5);
		clipChildren: false;
		aptitude: (aTaggerAptitude := GtCreationEditableTaggerAptitude new
					margin: (BlInsets
							top: 0
							bottom: 3
							left: 0
							right: 5);
					tagLabel: [ :aTag | 
						| aLabel |
						aLabel := BrEditor new fitContent
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
										defaultForeground: Color black);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to previous form item';
										description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
										combination: BlKeyCombination shiftTab;
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionBackward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to next form item';
										description: 'Moves to the next form item. If none is found, we cycle back to the first.';
										combination: (BlKeyCombination tab or: BlKeyCombination enter);
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionForward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]).

						aDescription blocShortcuts
							ifNotNil: [ :aBlockReturningCollection | 
								aBlockReturningCollection value
									do: [ :aShortcut | aLabel addShortcut: aShortcut ] ].

						aCompletionStrategy
							ifNotNil: [ (GtCompletionController on: aLabel strategy: aCompletionStrategy) install ].
						aContextMenuBlock
							ifNotNil: [ aLabel
									addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
											content: [ aContextMenuBlock
													value: aTag name
													value: aLabel
													value: aMemento ]) ].
						aLabel ]).
	aTagger
		when: BrTaggerAddTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget addTag: aRequest tag.
			aValue := aTagger tags collect: #name thenSelect: #isNotEmpty.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		when: BrTaggerRenameTagRequest
		do: [ :aRequest | 
			(aRequest tag name = aRequest newName) not
				ifTrue: [ | aValue |
					aRequest currentTarget renameTag: aRequest tag to: aRequest newName.
					aValue := aTagger tags collect: #name.

					GtMagritteBuilderUtility
						write: aValue asArray
						using: aDescription
						memento: aMemento
						element: aTagger ] ].
	aTagger
		when: BrTaggerRemoveTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget removeTag: aRequest tag.
			aValue := aTagger tags collect: #name.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theTagger :aSink | 
					| theValues |
					(theTagger tags isEmpty or: [ aSink value isChanged not ])
						ifTrue: [ theValues := aSink value currentValue.
							theTagger namedTags: theValues ] ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].
	GtMagritteBuilderUtility
		newValidationContainerWith: aTagger
		memento: aMemento
		using: aDescription ]

]

{ #category : #validations }
LcsBaseSlot >> validate: aValue [
	(LcsConditionsValidator newOn: self)
		validate: aValue
]

{ #category : #validations }
LcsBaseSlot >> validate: aValue context: aDomainObject [
	(LcsConditionsValidator newOn: self)
		validate: aValue context: aDomainObject
]

{ #category : #properties }
LcsBaseSlot >> validationConditions [
	^ self properties at: 'validationConditions' ifAbsentPut: [ LcsValidationConditions newOn: self ]
]

{ #category : #properties }
LcsBaseSlot >> validationConditions: anObject [
	self properties at: 'validationConditions' put: anObject
]
