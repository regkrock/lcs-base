Class {
	#name : 'LcsBaseSlotBuilder',
	#superclass : 'LcsCodeBuilderStep',
	#instVars : [
		'slotClassName',
		'slotDefinitionSelector',
		'slotDefinitionTemplate',
		'targetClass',
		'targetClassName',
		'targetModuleClass'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'testing' }
LcsBaseSlotBuilder class >> isAbstractSlotBuilder [
	[ self slotClass ] on: SubclassResponsibility do: [:s | ^ true ].
	^ false
]

{ #category : 'con' }
LcsBaseSlotBuilder class >> slotClass [
	self subclassResponsibility
]

{ #category : 'testing' }
LcsBaseSlotBuilder class >> volunteersFor: aSlotClass [
	self isAbstractSlotBuilder ifTrue: [ ^ false ].
	^ self slotClass = aSlotClass
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> addPropertiesTo: aSlotDefinitionMethodBuilder [
	"Note: The 'property' will be turned into a setter and value is argument
		ex: property 'slotName' and argument 'foo' will become the setter for the slot name.
		    fooSlotDefinitino new
		    	slotName: 'foo';
		    	yourself"
	self properties keysAndValuesDo: [ :key :value | 
		aSlotDefinitionMethodBuilder addProperty: key value: value ]
]

{ #category : 'gt views' }
LcsBaseSlotBuilder >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : 'code generation' }
LcsBaseSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : 'printing' }
LcsBaseSlotBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' , aString
]

{ #category : 'magritte - support' }
LcsBaseSlotBuilder >> classesOrNilsFor: aCollectionOfClassNames [ 
	"Return collection of Class. If a Class does not exist, `nil` value is used."

	<return: #Collection of: #Class>
	^ aCollectionOfClassNames
		collect: [ :eachClasstName | Smalltalk classOrTraitNamed: eachClasstName asString trimBoth ]
]

{ #category : 'execute' }
LcsBaseSlotBuilder >> commit [
	self buildJobSteps.
	self execute
]

{ #category : 'testing' }
LcsBaseSlotBuilder >> doesSlotDefinitionMethodExist [
	^ self targetClass class includesSelector: self slotDefinitionSelector
]

{ #category : 'testing' }
LcsBaseSlotBuilder >> doesTargetClassExist [
	^ self targetClass isClass
]

{ #category : 'magritte - support' }
LcsBaseSlotBuilder >> editableLabelAptitude [
	^ BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
		defaultForeground: Color black
]

{ #category : 'validation' }
LcsBaseSlotBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : 'gt views' }
LcsBaseSlotBuilder >> gtClassViewOn: aView [
	<gtView>
	self doesTargetClassExist ifFalse: [
		^ aView list
			title: 'Target(' , (self targetClassName ifNil: ['No Target Class']) displayString , ')';
			priority: 200;
			items: [ {'Not yet created'} ];
			yourself ].
	^ aView explicit
		title: 'Target(' ,self targetClass name , ')';
		priority: 200;
		stencil: [ (GtCoderElement forObject: self targetClass) disablePlayPage beNormalLevel ];
		yourself
]

{ #category : 'initialize' }
LcsBaseSlotBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new.
	self class slotClass notNil
		ifTrue: [ self slotClassName: self class slotClass name ]

]

{ #category : 'initialize' }
LcsBaseSlotBuilder >> initializeJobSteps [
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : 'command' }
LcsBaseSlotBuilder >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : 'testing' }
LcsBaseSlotBuilder >> isAbstractSlotBuilder [
	^ self class isAbstractSlotBuilder
]

{ #category : 'magritte - support' }
LcsBaseSlotBuilder >> moveToNextItemIn: aForm [
	^ BlShortcutWithAction new
		name: 'Move to next form item';
		description: 'Moves to the next form item. If none is found, we cycle back to the first.';
		combination: (BlKeyCombination tab or: BlKeyCombination enter);
		action: [ :anEvent | 
			BlFocusFinder new
				direction: BlFocusSearchDirectionForward new;
				root: aForm;
				referenceElement: anEvent currentTarget;
				nextFocusDo: #requestFocus ifNone: [  ] ]
]

{ #category : 'magritte - support' }
LcsBaseSlotBuilder >> moveToPreviousItemIn: aForm [
	^ BlShortcutWithAction new
		name: 'Move to previous form item';
		description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
		combination: BlKeyCombination shiftTab;
		action: [ :anEvent | 
			BlFocusFinder new
				direction: BlFocusSearchDirectionBackward new;
				root: aForm;
				referenceElement: anEvent currentTarget;
				nextFocusDo: #requestFocus ifNone: [  ] ]
]

{ #category : 'populate' }
LcsBaseSlotBuilder >> populateFrom: aSlotClassName [
	self properties removeAll.
	self slotClassName: aSlotClassName.
	self slotDefinitionTemplate: aSlotClassName asClass new.
	self slotName: self slotDefinitionTemplate slotName.
	self slotDefinitionTemplate properties keysAndValuesDo:  [ :key :value |
		self propertyAt: key put: value copy ]
]

{ #category : 'printing' }
LcsBaseSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ self targetClass ifNotNil: [ self targetClass name ] ]) asString
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> propertyAt: aName ifAbsent: aBlock [
	^ self properties at: aName ifAbsent: aBlock
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> propertyAt: aString ifAbsentPut: aBlock [ 
	^ self properties at: aString ifAbsentPut: aBlock
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> propertyAt: aString put: anObject [ 
	self properties at: aString put: anObject.
	self jobSteps propogateProperty: aString valueChangedTo: anObject
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotClassName [
	^ slotClassName
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : 'initialize' }
LcsBaseSlotBuilder >> slotDefinitionMethodBuilder [
	^ LcsSlotDefintionMethodBuilder newFrom: self
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotDefinitionSelector: aSymbolOrNil [
	slotDefinitionSelector := aSymbolOrNil
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotDefinitionTemplate [
	^ slotDefinitionTemplate
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> slotDefinitionTemplate: anObject [ 
	slotDefinitionTemplate := anObject
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> slotName [
	^ self propertyAt: 'slotName' ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> slotName: anObject [
	| slotName slotDefinitionName|
	slotName := 
		anObject isEmptyOrNil 
			ifTrue: [ anObject ] 
			ifFalse: [(anObject first asLowercase asString , 
						(anObject copyFrom: 2 to: anObject size))].
	self propertyAt: 'slotName' put: slotName.
	slotDefinitionName := 
		anObject isEmptyOrNil 
			ifTrue: [ anObject ] 
			ifFalse: [ (self slotName , 'SlotDefinition') asSymbol].
	self slotDefinitionSelector: slotDefinitionName
]

{ #category : 'margritte' }
LcsBaseSlotBuilder >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self targetClass ifNil: [ #() ] ifNotNil: [ :class | class allInstVarNames ].
	^ MAStringDescription new
		label: 'Slot Name';
		priority: 1;
		accessor: #slotName;
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> slotTypes [
	^ self propertyAt: 'slotTypes' ifAbsent: [ OrderedCollection new] 
]

{ #category : 'properties' }
LcsBaseSlotBuilder >> slotTypes: anObject [
	self propertyAt: 'slotTypes' put: anObject
]

{ #category : 'margritte' }
LcsBaseSlotBuilder >> slotTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slot Types';
		priority: 30;
		accessor: (LcsMAPluggableAccessor 
						accessors: #(#slotTypes)
						read: [ :classes | classes collect: [ :each | each name] ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asClass ] ) ]);
		classes: { String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil);
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
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed';
		addCondition: [ :aValue | 
				aValue
					allSatisfy: [ :eachClassName | 
						LcsBuilderLogger log: eachClassName isClass asString , ' - ' , eachClassName asString.
						eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | 
				| givenTraitsOrNils |
				givenTraitsOrNils := self classesOrNilsFor: aValue.
				givenTraitsOrNils allSatisfy: [ :each | each isNil or: [ each isClass ] ] ]
			labelled: 'Only classes are allowed';
		beRequired
]

{ #category : 'magritte - support' }
LcsBaseSlotBuilder >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
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
								aptitude: self editableLabelAptitude;
								addShortcut: (self moveToPreviousItemIn: aForm);
								addShortcut: (self moveToNextItemIn: aForm).

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

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetClass [
	^ self targetClassName ifNotNil: [ 
		[ self targetClassName asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ] ]
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetClass: aClass [
	self targetClassName: aClass name
]

{ #category : 'margritte' }
LcsBaseSlotBuilder >> targetClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Class';
		priority: 3;
		accessor: #'targetClass';
		beReadOnly;
		blocShortcuts: [ 
			{BlShortcutWithAction new
				name: 'Browse class';
				description: 'Browses the class indicated by the editor';
				combination: BlKeyCombination primaryB;
				action: [ :anEvent | anEvent target phlow spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetClassName [
	^ targetClassName
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetClassName: aString [
	targetClassName := aString
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetModuleClass [
	^ targetModuleClass
]

{ #category : 'accessing' }
LcsBaseSlotBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]
