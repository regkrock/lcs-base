Class {
	#name : #LcsSlotCreationForm,
	#superclass : #LcsBaseSlotCreationForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'mode',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsSlotCreationForm class >> builderClass [
	^ LcsCodeBuilderStep
]

{ #category : #configuration }
LcsSlotCreationForm class >> defaultSlotClass [
	^ LcsAccessorSlot
]

{ #category : #testing }
LcsSlotCreationForm class >> isAdditionForm [
	^ true
]

{ #category : #'instance creation' }
LcsSlotCreationForm class >> newEditOn: aTargetClass [
	^ self new 
		initializeEditOn: aTargetClass;
		yourself
]

{ #category : #configuration }
LcsSlotCreationForm class >> priority [
	^ 10
]

{ #category : #configuration }
LcsSlotCreationForm class >> slotComponentName [
	^ 'Accessor'
]

{ #category : #private }
LcsSlotCreationForm >> accessPathFrom: anMAChainAccessor [
	| accessor path|
	path := OrderedCollection new.
	accessor := anMAChainAccessor. 
	[ accessor respondsTo: #next ] whileTrue: [
		path add: accessor accessor selector.
		accessor := accessor next ]. 
	path add: accessor selector.
	^ path
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> addAccessorToBeginningOfAccessPath: aDescription [
	(aDescription accessor isKindOf: LcsMAPluggableAccessor) ifTrue: [ 
		aDescription accessor addSelectorToStartOfAccessChain: #slotModelBuilder.
		^aDescription ].
			
	(aDescription accessor isKindOf: MASelectorAccessor) ifTrue: [ 
		aDescription accessor: (MAChainAccessor accessors: {#slotModelBuilder. aDescription accessor selector}).
		^ aDescription ].
		
	(aDescription accessor isKindOf: MAChainAccessor) ifTrue: [ 
		aDescription accessor: (
			MAChainAccessor accessors: ( 
				(self accessPathFrom: aDescription accessor )
					addFirst: #slotModelBuilder;
					yourself)).
		^ aDescription ].
		
	^ aDescription
]

{ #category : #magritte }
LcsSlotCreationForm >> allowEmptyIntialValueDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #allowEmptyIntialValue
]

{ #category : #magritte }
LcsSlotCreationForm >> allowNilDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #allowNil
]

{ #category : #magritte }
LcsSlotCreationForm >> allowNullDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #allowNull
]

{ #category : #converting }
LcsSlotCreationForm >> asElement [
	| viewModel |
	viewModel := self asGtMagritteViewModel focusFirstInputField.
	self onElementCreated
		ifNotNil: [ :aCallback | viewModel onElementCreated: aCallback ].
	^ viewModel asElement
]

{ #category : #private }
LcsSlotCreationForm >> classNamed: aValue [
	^ Smalltalk classNamed: aValue trim
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> classShortcuts [
	^ {BlShortcutWithAction new
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
					spawnObject: anEvent target text asString asClass gtReferences ]}
]

{ #category : #private }
LcsSlotCreationForm >> classesOrNilsFor: aCollectionOfClassNames [ 
	"Return collection of Class. If a Class does not exist, `nil` value is used."

	<return: #Collection of: #Class>
	^ aCollectionOfClassNames
		collect: [ :eachClasstName | Smalltalk classOrTraitNamed: eachClasstName asString trimBoth ]
]

{ #category : #magritte }
LcsSlotCreationForm >> collectionMemberTypesDefinition [
	<magritteDescription>
	^ self magritteDescriptionFor: #collectionMemberTypes
]

{ #category : #magritte }
LcsSlotCreationForm >> collectionSlotModuleNameDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #collectionSlotModuleName
]

{ #category : #magritte }
LcsSlotCreationForm >> collectionSlotNameDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #collectionSlotName
]

{ #category : #callbacks }
LcsSlotCreationForm >> commit [
	self error: 'Do not use this'.
	"self slotModelBuilder commit"
]

{ #category : #callbacks }
LcsSlotCreationForm >> commitPackage [
	| aPackage |
	(RPackageOrganizer default includesPackageNamed: packageAndTagName packageName)
		ifTrue: [ aPackage := RPackageOrganizer default
					packageNamed: packageAndTagName packageName.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage classTagNamed: aTagName ifAbsent: [ aPackage addClassTag: aTagName ] ] ]
		ifFalse: [ aPackage := (RPackage named: packageAndTagName packageName)
					register.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage addClassTag: aTagName ] ]
]

{ #category : #private }
LcsSlotCreationForm >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :aBrEditor | aBrEditor phlow spawnObject: aBrEditor text asString asClass gtReferences ]}
]

{ #category : #configuration }
LcsSlotCreationForm >> defaultSlotClass [	
	^ self class defaultSlotClass
]

{ #category : #private }
LcsSlotCreationForm >> ghostTextFor: aString [
	^ BrGhostTextAttribute
		for: (aString asRopedText glamorousFormEditorCodeFontAndSize foreground: Color lightGray)
]

{ #category : #testing }
LcsSlotCreationForm >> hasPackageAndTag [
	^ true
]

{ #category : #magritte }
LcsSlotCreationForm >> initialValueBlockDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #initialValueBlock
]

{ #category : #initialize }
LcsSlotCreationForm >> initialize [
	super initialize.
	self slotClassName: ''
]

{ #category : #initialize }
LcsSlotCreationForm >> initializeEditOn: aTargetClass [
	self initializeOn: aTargetClass.
	self mode: #edit

]

{ #category : #initialize }
LcsSlotCreationForm >> initializeOn: aTargetClass [ 
	super initializeOn: aTargetClass .
	self mode: #add
]

{ #category : #testing }
LcsSlotCreationForm >> isEditMode [
	self mode = #edit
]

{ #category : #testing }
LcsSlotCreationForm >> isInstanceSideClass: aValue [
	| aClass |
	aClass := self classNamed: aValue.
	^ aClass isNil or: [ aClass isInstanceSide ]
]

{ #category : #testing }
LcsSlotCreationForm >> isSlotClass: aValue [ 
	| class |
	class := self classNamed: aValue.
	class isNil ifTrue: [ ^ false ].
	^ class inheritsFrom: LcsBaseSlot
]

{ #category : #testing }
LcsSlotCreationForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = LcsCodeBuilderStep
]

{ #category : #testing }
LcsSlotCreationForm >> isSlotModelBuilderReified [
	^ self slotModelBuilder  class ~= LcsCodeBuilderStep
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ self slotModelBuilder class = LcsCodeBuilderStep 
		ifTrue: [ self magritteOpenSlotModelBuilderAcceptAction ]
		ifFalse: [ self magritteUpdateSlotModelBuilderAcceptAction ]
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> magritteDescriptionFor: aSlotNameSymbol [
	| aDescription |
	
	(self slotModelBuilder respondsTo: aSlotNameSymbol) ifFalse: [ ^ nil ].
	
	aDescription := self slotModelBuilder perform: (aSlotNameSymbol , 'Description') asSymbol.
	
	self addAccessorToBeginningOfAccessPath: aDescription.
	^ aDescription
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> magritteInspectAction [
	"<magritteActionDescription>"
	^ MAActionDescription new
		priority: 30;
		label: 'Inspect';
		blocIcon: BrGlamorousVectorIcons inspect;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aButton phlow spawnObject: aMemento ]);
		beToolbarAction
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> magritteOpenSlotModelBuilderAcceptAction [
	^ super magritteAcceptAction
		label: 'Open Builder';
		action: self openSpecifiedSlotBuilderFormAction;
		beEnabledOnValidOverallStatus
]

{ #category : #magritte }
LcsSlotCreationForm >> magritteUpdateSlotModelBuilderAcceptAction [
	^ super magritteAcceptAction
		label: 'Update Builder';
		action: self commitSlotBuilderChangesAction;
		beEnabledOnValidOverallStatus
]

{ #category : #accessing }
LcsSlotCreationForm >> mode [
	^ mode
]

{ #category : #accessing }
LcsSlotCreationForm >> mode: aString [ 
	mode := aString
]

{ #category : #magritte }
LcsSlotCreationForm >> numberOfDecimalsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #numberOfDecimals
]

{ #category : #accessing }
LcsSlotCreationForm >> onElementCreated [
	^ onElementCreated
]

{ #category : #accessing }
LcsSlotCreationForm >> onElementCreated: aBlock [
	onElementCreated := aBlock
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> openSpecifiedSlotBuilderFormAction [
	^ GtMagritteAction new
		"beInFutureProcess;
		beWithFutureResponse;"
		action: [ :aModel :aButton :aMemento :aDescription | 
			aModel reifySlotModelBuilder.
			aButton phlow fireViewUpdateWish ]
]

{ #category : #magritte }
LcsSlotCreationForm >> packageAndTagDescription [
	"<magritteDescription>"
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTagName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> packageAndTagName [

	^ packageAndTagName
]

{ #category : #accessing }
LcsSlotCreationForm >> packageAndTagName: anObject [

	packageAndTagName := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> postUpdateActionsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #postUpdateActions
]

{ #category : #magritte }
LcsSlotCreationForm >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #prevalidationTransformBlock
]

{ #category : #callbacks }
LcsSlotCreationForm >> reifySlotModelBuilder [
	self
		slotModelBuilder: (self slotBuilderClass new
				targetClass: self targetClass;
				targetClassName: self targetClass name asString;
				populateFrom: self slotClassName;
				buildJobSteps;
				yourself)
]

{ #category : #magritte }
LcsSlotCreationForm >> requiredDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #required
]

{ #category : #private }
LcsSlotCreationForm >> selectInNavigationModel: aNavigationModel anInstance: anInstance [
	aNavigationModel selectPackage: anInstance package.

	anInstance tags
		ifNotEmpty: [ aNavigationModel
				selectPackageTag: (anInstance package classTagNamed: anInstance tags first) ].

	aNavigationModel selectClass: anInstance
]

{ #category : #private }
LcsSlotCreationForm >> slotBuilderClass [
	self slotClassWithSuperclasses do: [ :eachTargetSlotClass |
		LcsBaseSlotBuilder allSubclasses do: [ :eachSlotBuilderClass |
			eachSlotBuilderClass slotClass = eachTargetSlotClass
				ifTrue: [ ^ eachSlotBuilderClass ] ] ].
	^ LcsAccessorSlotBuilder
]

{ #category : #callbacks }
LcsSlotCreationForm >> slotClassChangedTo: aClassName [
	self slotClassName: aClassName.
	self reifySlotModelBuilder
]

{ #category : #magritte }
LcsSlotCreationForm >> slotClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Definition Class';
		autoAccept: true;
		priority: 3;
		default: '';
		accessor: (MASelectorAccessor read: #slotClassName write: #slotClassChangedTo:);
		readOnly: self isSlotModelBuilderReified;
		blocCompletion: [ GtStringsCompletionStrategy new completions: self slotClasses ];
		blocShortcuts: [ self classShortcuts ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | self isSlotClass: aValue ]
			labelled: 'Must be or a subclass of ' , self defaultSlotClass name;
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> slotClassName [
	^ slotClassName
]

{ #category : #accessing }
LcsSlotCreationForm >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : #private }
LcsSlotCreationForm >> slotClassWithSuperclasses [
	^ (self slotClassName asClass withAllSuperclasses) reject: [ :each |
		LcsBaseSlot inheritsFrom: each ]
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> slotClasses [
	^ GtPrefixTree
		withAll: ((LcsBaseSlot withAllSubclasses reject: [ :each | each isAbstract ])
				collect: [ :each | each name ])
]

{ #category : #magritte }
LcsSlotCreationForm >> slotNameDescription [
	<magritteDescription>
	^ (self magritteDescriptionFor: #slotName) ifNotNil: [ :description |
		description
			priority: 4;
			yourself ]
]

{ #category : #magritte }
LcsSlotCreationForm >> slotTypesDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #slotTypes
]

{ #category : #private }
LcsSlotCreationForm >> toolFor: anInstance [
	^ GtClassCoderTool forClass: anInstance
]

{ #category : #magritte }
LcsSlotCreationForm >> validationConditionItemsDescription [
	"<magritteDescription>"
	^ self magritteDescriptionFor: #validationConditionItems
]

{ #category : #magritte }
LcsSlotCreationForm >> validationConditionsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #validationConditions
]

{ #category : #'magritte - support' }
LcsSlotCreationForm >> visualizeSlotModelBuilderVia: aButton [
	^ aButton "parent parent parent parent parent parent parent" phlow
		fireViewUpdateWish
]
