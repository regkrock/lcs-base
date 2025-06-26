Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotName',
		'slotDefinitionSelector',
		'targetClassName',
		'targetModuleClass',
		'slotDefinitionClassName',
		'slotTypes',
		'validationConditions',
		'targetPackageName',
		'targetClass',
		'properties',
		'slotDefinitionTemplate'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsSlotDefinitionBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #configuration }
LcsSlotDefinitionBuilder class >> slotDefinitionClass [
	"Subclasses can override this method to provide a default"
	^ LcsSlotDefinition
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addClassesToUmlModel: umlModel [
	umlModel addClassNamed: self targetClassName.
	self addTargetModuleClassTo: umlModel
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> addSlotType: aClassOrClassName [
	| className |
	className := aClassOrClassName isClass 
					ifTrue: [ aClassOrClassName name asString ] 
					ifFalse: [ aClassOrClassName asString ].
	(self slotTypes includes: className) ifFalse: [
		self slotTypes add: className ]
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> addStepNumberTo: aString [
	^ self stepNumber , '.' , aString
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addTargetClassTo: classesModel [
	self targetClass
		ifNil: [ classesModel proposedClassModelFor: self targetClassName ]
		ifNotNil: [ :class | classesModel existingClassModelFor: class ]
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> addTargetModuleClassTo: classesModel [
	self targetModuleClass notNil
		ifTrue: [ classesModel existingClassModelFor: self targetModuleClass ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> addValidationCondition: aStringBlock description: aDescription [
	self validationConditions add: aStringBlock -> aDescription
]

{ #category : #property }
LcsSlotDefinitionBuilder >> allowNil [
	^ self propertyAt: 'allowNil' ifAbsent: [ false ]
]

{ #category : #property }
LcsSlotDefinitionBuilder >> allowNil: anObject [ 
	self propertyAt: 'allowNil' put: anObject
]

{ #category : #margritte }
LcsSlotDefinitionBuilder >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 8;
		accessor: (MAPluggableAccessor
				read: [ :aModel | self allowNil ]
				write: [ :aModel :aValue | self allowNil: aValue ]);
		autoAccept: true;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #'job steps' }
LcsSlotDefinitionBuilder >> buildJobSteps [
	self addJobStep: self slotInstanceVariableBuilder.
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : #'magritte - support' }
LcsSlotDefinitionBuilder >> classesOrNilsFor: aCollectionOfClassNames [ 
	"Return collection of Class. If a Class does not exist, `nil` value is used."

	<return: #Collection of: #Class>
	^ aCollectionOfClassNames
		collect: [ :eachClasstName | Smalltalk classOrTraitNamed: eachClasstName asString trimBoth ]
]

{ #category : #uninstall }
LcsSlotDefinitionBuilder >> clearTargetClass: aClass [
	self targetClass == aClass
		ifTrue: [ self targetClassName: nil ]
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionBuilder >> commit [
	self buildJobSteps.
	self execute
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self targetClass class includesSelector: self slotDefinitionSelector
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesTargetClassExist [
	^ self targetClass isClass
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> getterAndSetterMethodsBuilder [
	^ LcsSlotGetterAndSetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> gtClassViewOn: aView [
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
LcsSlotDefinitionBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 3;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton

]

{ #category : #property }
LcsSlotDefinitionBuilder >> initialValueBlock [
	^ self propertyAt: 'initialValueBlock' ifAbsent: [ [ ] ]
]

{ #category : #property }
LcsSlotDefinitionBuilder >> initialValueBlock: aString [
	^ self propertyAt: 'initialValueBlock' put: aString
]

{ #category : #margritte }
LcsSlotDefinitionBuilder >> initialValueBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Initial Value Block';
		priority: 9;
		accessor: (MAPluggableAccessor
				read: [ :aModel | self initialValueBlock ]
				write: [ :aModel :aValue | self initialValueBlock: aValue ]);
		autoAccept: true;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new.
	self validationConditions: OrderedCollection new.
	self class slotDefinitionClass notNil
		ifTrue: [ self slotDefinitionClassName: self class slotDefinitionClass name ].
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self).
	self properties: Dictionary new
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #command }
LcsSlotDefinitionBuilder >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : #'job steps' }
LcsSlotDefinitionBuilder >> installSlotDefinition [
	self targetClass installSlotDefinition: self slotDefinitionSelector
]

{ #category : #populate }
LcsSlotDefinitionBuilder >> populateFrom: aSlotDefinitionClassName [
	self slotDefinitionClassName: aSlotDefinitionClassName.
	self slotDefinitionTemplate: aSlotDefinitionClassName asClass new.
	 self slotDefinitionTemplate slotName ifNotNil: [
		self slotName: self slotDefinitionTemplate slotName ].
	self slotTypes removeAll.
	self slotTypes addAll: (self slotDefinitionTemplate slotTypes collect: [ :each | each name asString ]).
	self allowNil: self slotDefinitionTemplate  allowNil.
	self required: self slotDefinitionTemplate required.
	self initialValueBlock: self slotDefinitionTemplate initialValueBlockSourceCode
]

{ #category : #printing }
LcsSlotDefinitionBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: (self slotName ifNil: [ '<missing>' ]);
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ self targetClass ifNotNil: [ self targetClass name ] ]) asString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> properties [
	^ properties
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> properties: anObject [ 
	properties := Dictionary new
]

{ #category : #property }
LcsSlotDefinitionBuilder >> propertyAt: aName [
	self properties at: aName ifAbsent: [ nil ]
]

{ #category : #property }
LcsSlotDefinitionBuilder >> propertyAt: aName ifAbsent: aBlock [
	^ self properties at: aName ifAbsent: aBlock
]

{ #category : #property }
LcsSlotDefinitionBuilder >> propertyAt: aName put: anObject [
	self properties at: aName put: anObject.
	self jobSteps do: [ :eachStep | (eachStep respondsTo: (aName , ':' asSymbol))
		ifTrue: [ eachStep perform: (aName , ':' asSymbol) with: anObject ] ]
]

{ #category : #property }
LcsSlotDefinitionBuilder >> required [
	^ self propertyAt: 'required' ifAbsent: [ false ]
]

{ #category : #property }
LcsSlotDefinitionBuilder >> required: anObject [ 
	self propertyAt: 'required' put: anObject
]

{ #category : #margritte }
LcsSlotDefinitionBuilder >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 9;
		accessor: (MAPluggableAccessor
				read: [ :aModel | self required ]
				write: [ :aModel :aValue | self required: aValue ]);
		autoAccept: true;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionClassName [
	^ slotDefinitionClassName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionClassName: anObject [
	slotDefinitionClassName := anObject
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> slotDefinitionMethodBuilder [
	^ LcsSlotDefintionMethodBuilder newFrom: self
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
		"ifNil: [ slotDefinitionSelector := ((self slotName ifNil: [ 'undefined' ]) , 'SlotDefinition') asSymbol ]"
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector: aSymbol [
	slotDefinitionSelector := aSymbol asSymbol
]

{ #category : #populate }
LcsSlotDefinitionBuilder >> slotDefinitionTemplate [
	^ slotDefinitionTemplate
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionTemplate: anObject [ 
	slotDefinitionTemplate := anObject
]

{ #category : #initialize }
LcsSlotDefinitionBuilder >> slotInstanceVariableBuilder [
	^ LcsSlotInstanceVariableBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName [
	^ self propertyAt: 'slotName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName: anObject [
	self propertyAt: 'slotName' put: (anObject first asLowercase asString , (anObject copyFrom: 2 to: anObject size)).
	self slotDefinitionSelector: self slotName , 'SlotDefinition'
]

{ #category : #margritte }
LcsSlotDefinitionBuilder >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self targetClass allInstVarNames.
	^ MAStringDescription new
		label: 'Slot Name';
		autoAccept: true;
		priority: 1;
		accessor: (MAPluggableAccessor
				read: [ :aModel | self slotName ]
				write: [ :aModel :aValue | self slotName: aValue ]);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #margritte }
LcsSlotDefinitionBuilder >> slotTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slot Types';
		priority: 30;
		accessor: (MAPluggableAccessor read: [ :aModel | self slotTypes ] write: [ :aModel :aValue | self slotTypes: aValue ]);
		classes: {String};
		autoAccept: true;
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
			labelled: 'All class names must be unique';
		addCondition: [ :aValue | 
				aValue
					allSatisfy: [ :eachClassName | (Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | 
				| givenTraitsOrNils |
				givenTraitsOrNils := self classesOrNilsFor: aValue.
				givenTraitsOrNils allSatisfy: [ :each | each isNil or: [ each isClass ] ] ]
			labelled: 'Only classes are allowed';
		beRequired
]

{ #category : #'magritte - support' }
LcsSlotDefinitionBuilder >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
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

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass [
	^ self targetClassName ifNotNil: [ 
		[ self targetClassName asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ] ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClass: aClass [
	self targetClassName: aClass name
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName: aString [
	targetClassName := aString
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetPackageName: anObject [
	targetPackageName := anObject
]

{ #category : #verification }
LcsSlotDefinitionBuilder >> targetSlotDefinition [
	^ self targetClass perform: self slotDefinitionSelector
]

{ #category : #command }
LcsSlotDefinitionBuilder >> updateSlotModel [
	super updateSlotModel.
	self installSlotDefinition
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> validationConditions [
	^ validationConditions
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> validationConditions: anObject [
	validationConditions := anObject
]

{ #category : #'gt views' }
LcsSlotDefinitionBuilder >> viewCodeButton [
	self targetClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self targetClass 
]
