Class {
	#name : #LcsAccessorSlotBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotDefinitionSelector',
		'targetClassName',
		'targetModuleClass',
		'targetPackageName',
		'targetClass',
		'slotDefinitionTemplate',
		'slotClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsAccessorSlotBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #configuration }
LcsAccessorSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsAccessorSlot
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> addClassesToUmlModel: umlModel [
	umlModel addClassNamed: self targetClassName.
	self addTargetModuleClassTo: umlModel
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> addPropertiesTo: aSlotDefinitionMethodBuilder [
	"Note: The 'property' will be turned into a setter and value is argument
		ex: property 'slotName' and argument 'foo' will become the setter for the slot name.
		    fooSlotDefinitino new
		    	slotName: 'foo';
		    	yourself"
	self properties keysAndValuesDo: [ :key :value | 
		aSlotDefinitionMethodBuilder addProperty: key value: value ]
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #'code generation' }
LcsAccessorSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> addSlotType: aClassOrClassName [
	| className |
	className := aClassOrClassName isClass 
					ifTrue: [ aClassOrClassName name asString ] 
					ifFalse: [ aClassOrClassName asString ].
	(self slotTypes includes: className) ifFalse: [
		self slotTypes add: className ]
]

{ #category : #printing }
LcsAccessorSlotBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' , aString
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> addTargetClassTo: classesModel [
	self targetClass
		ifNil: [ classesModel proposedClassModelFor: self targetClassName ]
		ifNotNil: [ :class | classesModel addClassModelForExisting: class ]
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> addTargetModuleClassTo: classesModel [
	self targetModuleClass notNil
		ifTrue: [ classesModel addClassModelForExisting: self targetModuleClass ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> addValidationCondition: aValidationCondition [
	self validationConditions addValidationCondition: aValidationCondition
]

{ #category : #'slot model' }
LcsAccessorSlotBuilder >> addValidationCondition: aBlock description: aDescription [
	self validationConditions addValidationCondition: aBlock description: aDescription
]

{ #category : #property }
LcsAccessorSlotBuilder >> allowNil [
	^ self propertyAt: 'allowNil' ifAbsent: [ false ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> allowNil: anObject [ 
	self propertyAt: 'allowNil' put: anObject
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 8;
		accessor: #'allowNil';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> beAllowNil [
	self allowNil: true
]

{ #category : #'job steps' }
LcsAccessorSlotBuilder >> buildJobSteps [
	self addJobStep: self slotInstanceVariableBuilder.
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> classesOrNilsFor: aCollectionOfClassNames [ 
	"Return collection of Class. If a Class does not exist, `nil` value is used."

	<return: #Collection of: #Class>
	^ aCollectionOfClassNames
		collect: [ :eachClasstName | Smalltalk classOrTraitNamed: eachClasstName asString trimBoth ]
]

{ #category : #uninstall }
LcsAccessorSlotBuilder >> clearTargetClass: aClass [
	self targetClass == aClass
		ifTrue: [ self targetClassName: nil ]
]

{ #category : #execute }
LcsAccessorSlotBuilder >> commit [
	self buildJobSteps.
	self execute
]

{ #category : #property }
LcsAccessorSlotBuilder >> defaultPrevalidationTransformBlock [
	^ [  ]
]

{ #category : #testing }
LcsAccessorSlotBuilder >> doesSlotDefinitionMethodExist [
	^ self targetClass class includesSelector: self slotDefinitionSelector
]

{ #category : #testing }
LcsAccessorSlotBuilder >> doesTargetClassExist [
	^ self targetClass isClass
]

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> editableLabelAptitude [
	^ BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
		defaultForeground: Color black
]

{ #category : #validation }
LcsAccessorSlotBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> getterAndSetterMethodsBuilder [
	^ LcsSlotGetterAndSetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : #'slot model' }
LcsAccessorSlotBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> gtClassViewOn: aView [
	<gtView>
	self doesTargetClassExist ifFalse: [
		^ aView list
			title: (self targetClassName ifNil: ['No Target Class']) displayString;
			priority: 200;
			items: [ {'Not yet created'} ];
			yourself ].
	^ aView explicit
		title: self targetClass name;
		priority: 200;
		stencil: [ (GtCoderElement forObject: self targetClass) disablePlayPage beNormalLevel ];
		yourself
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Properties';
		items: [ self properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		send: #value;
		actionUpdateButton
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 3;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton

]

{ #category : #property }
LcsAccessorSlotBuilder >> initialValueBlock [
	^ self propertyAt: 'initialValueBlock' ifAbsent: [ [ ] ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> initialValueBlock: aString [
	^ self propertyAt: 'initialValueBlock' put: aString
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> initialValueBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Initial Value Block [ :domainObject :slot | ';
		priority: 9;
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#initialValueBlock)
						arguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new.
	self validationConditions: (LcsValidationConditions newOn: self).
	self class slotClass notNil
		ifTrue: [ self slotClassName: self class slotClass name ]

]

{ #category : #initialize }
LcsAccessorSlotBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #command }
LcsAccessorSlotBuilder >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : #'job steps' }
LcsAccessorSlotBuilder >> installSlotDefinition [
	self targetClass installSlotDefinition: self slotDefinitionSelector
]

{ #category : #testing }
LcsAccessorSlotBuilder >> isNilAllowed [
	^ self allowNil == true
]

{ #category : #querying }
LcsAccessorSlotBuilder >> jobStep: anInteger [
	^ self jobSteps jobStep: anInteger
]

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> moveToNextItemIn: aForm [
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

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> moveToPreviousItemIn: aForm [
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

{ #category : #populate }
LcsAccessorSlotBuilder >> populateFrom: aSlotClassName [
	self properties removeAll.
	self slotClassName: aSlotClassName.
	self slotDefinitionTemplate: aSlotClassName asClass new.
	self slotName: self slotDefinitionTemplate slotName.
	self slotDefinitionTemplate properties keysAndValuesDo:  [ :key :value |
		self propertyAt: key put: value copy ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> prevalidationTransformBlock [
	^ self propertyAt: 'prevalidationTransformBlock' ifAbsent: [ self defaultPrevalidationTransformBlock ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> prevalidationTransformBlock: aString [
	^ self propertyAt: 'prevalidationTransformBlock' put: aString
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Prevalidation Transform Block [ :value :slot | ';
		priority: 11;
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#prevalidationTransformBlock )
						arguments: LcsAccessorSlot valueSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #printing }
LcsAccessorSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ self targetClass ifNotNil: [ self targetClass name ] ]) asString
]

{ #category : #property }
LcsAccessorSlotBuilder >> propertyAt: aName [
	^ self properties at: aName ifAbsent: [ nil ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> propertyAt: aName ifAbsent: aBlock [
	^ self properties at: aName ifAbsent: aBlock
]

{ #category : #properties }
LcsAccessorSlotBuilder >> propertyAt: aString ifAbsentPut: aBlock [ 
	^ self properties at: aString ifAbsentPut: aBlock
]

{ #category : #properties }
LcsAccessorSlotBuilder >> propertyAt: aString put: anObject [ 
	self properties at: aString put: anObject.
	self jobSteps propogateProperty: aString valueChangedTo: anObject
]

{ #category : #validations }
LcsAccessorSlotBuilder >> removeValidationCondition: aValidationCondition [
	self validationConditions removeValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsAccessorSlotBuilder >> removeValidationConditionWithDescription: aString [
	self validationConditions removeValidationConditionWithDescription: aString
]

{ #category : #property }
LcsAccessorSlotBuilder >> required [
	^ self propertyAt: 'required' ifAbsent: [ false ]
]

{ #category : #property }
LcsAccessorSlotBuilder >> required: anObject [ 
	self propertyAt: 'required' put: anObject
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 9;
		accessor: #required;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotClassName [
	^ slotClassName
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> slotDefinitionMethodBuilder [
	^ LcsSlotDefintionMethodBuilder newFrom: self
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotDefinitionSelector: aSymbolOrNil [
	slotDefinitionSelector := aSymbolOrNil
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotDefinitionTemplate [
	^ slotDefinitionTemplate
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> slotDefinitionTemplate: anObject [ 
	slotDefinitionTemplate := anObject
]

{ #category : #initialize }
LcsAccessorSlotBuilder >> slotInstanceVariableBuilder [
	^ LcsSlotInstanceVariableBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : #properties }
LcsAccessorSlotBuilder >> slotName [
	^ self propertyAt: 'slotName' ifAbsent: [ nil ]
]

{ #category : #properties }
LcsAccessorSlotBuilder >> slotName: anObject [
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

{ #category : #margritte }
LcsAccessorSlotBuilder >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self targetClass ifNil: [ #() ] ifNotNil: [ :class | class allInstVarNames ].
	^ MAStringDescription new
		label: 'Slot Name';
		priority: 1;
		accessor: #slotName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : #properties }
LcsAccessorSlotBuilder >> slotTypes [
	^ self propertyAt: 'slotTypes' ifAbsent: [ OrderedCollection new] 
]

{ #category : #properties }
LcsAccessorSlotBuilder >> slotTypes: anObject [
	self propertyAt: 'slotTypes' put: anObject
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> slotTypesDescription [
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
				andContextMenuBlock: [ :aClass :anElement :aMemento | 
					aMemento overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createClassContextMenuContentFor: aClass editor: anElement ] ]);
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
						self traceCr: eachClassName isClass asString , ' - ' , eachClassName asString.
						eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | 
				| givenTraitsOrNils |
				givenTraitsOrNils := self classesOrNilsFor: aValue.
				givenTraitsOrNils allSatisfy: [ :each | each isNil or: [ each isClass ] ] ]
			labelled: 'Only classes are allowed';
		beRequired
]

{ #category : #'magritte - support' }
LcsAccessorSlotBuilder >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
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

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetClass [
	^ self targetClassName ifNotNil: [ 
		[ self targetClassName asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ] ]
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetClass: aClass [
	self targetClassName: aClass name
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> targetClassDescription [
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

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetClassName: aString [
	targetClassName := aString
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsAccessorSlotBuilder >> targetPackageName: anObject [
	targetPackageName := anObject
]

{ #category : #verification }
LcsAccessorSlotBuilder >> targetSlotDefinition [
	^ self targetClass perform: self slotDefinitionSelector
]

{ #category : #command }
LcsAccessorSlotBuilder >> updateSlotModel [
	super updateSlotModel.
	self installSlotDefinition
]

{ #category : #properties }
LcsAccessorSlotBuilder >> validationConditions [
	^ self propertyAt: #validationConditions ifAbsentPut: [ LcsValidationConditions newOn: self]
]

{ #category : #properties }
LcsAccessorSlotBuilder >> validationConditions: anObject [
	self propertyAt: #validationConditions put: anObject
]

{ #category : #margritte }
LcsAccessorSlotBuilder >> validationConditionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#validationConditions #collection));
		  "accessor: #validationConditions;"
		  label: 'Validation Conditions';
		  default: #(  );
		  classes: { LcsValidationCondition };
		  priority: 25;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [  LcsValidationCondition new ]
]

{ #category : #'gt views' }
LcsAccessorSlotBuilder >> viewCodeButton [
	self targetClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self targetClass 
]
