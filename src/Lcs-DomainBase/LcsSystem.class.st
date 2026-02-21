"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : 'LcsSystem',
	#superclass : 'LcsModule',
	#instVars : [
		'status',
		'systemSlotModel',
		'globalCollections',
		'uuidGenerator'
	],
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'system model' }
LcsSystem class >> addMyDomainClassHeirarchyTo: prebootstrapClasses [
	self allClassBetweenMyselfAndLcsDomainObject
		do: [ :each | (prebootstrapClasses includes: each) ifFalse: [ prebootstrapClasses add: each ] ].
	prebootstrapClasses add: self.
	prebootstrapClasses addAll: self allSubmoduleClasses
]

{ #category : 'configuration' }
LcsSystem class >> defaultModuleName [
	^ 'System'
]

{ #category : 'slot definitions' }
LcsSystem class >> globalCollectionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'globalCollections';
		addSlotType: LcsGlobalCollections;
		addCollectionMemberType: LcsDomainCollection;
		yourself
]

{ #category : 'testing' }
LcsSystem class >> isApplicationSystemClass [
	^ true
]

{ #category : 'instance creation' }
LcsSystem class >> new [
	"A factory pattern is used here. The creation of the system is delegated to the system manager"
	^ self basicNew
		initialize;
		yourself
]

{ #category : 'slot definitions' }
LcsSystem class >> statusSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSystemStatusSlot new
]

{ #category : 'configuration' }
LcsSystem class >> systemBootstrapDomainClasses [
	| prebootstrapClasses |
	prebootstrapClasses := 
		OrderedCollection new
			addAll: ((#'Lcs-SystemManagement' asPackage) classesTaggedWith: 'Domain');
			add: LcsSystemSlotModel;
			add: LcsBaseSystemStatus;
			addAll: LcsBaseSystemStatus subclasses;
			add: LcsModules;
			yourself.
	self addMyDomainClassHeirarchyTo: prebootstrapClasses.
	^ prebootstrapClasses
]

{ #category : 'slot definitions' }
LcsSystem class >> systemSlotModelSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'systemSlotModel';
		addSlotType: LcsSystemSlotModel;
		addCollectionMemberType: LcsSlotModel;
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsSystem class >> uuidGeneratorSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUuidGeneratorSlot new
]

{ #category : 'security' }
LcsSystem >> _parent [
	"Do not use in normal situations"
	^ parent
]

{ #category : 'accessing' }
LcsSystem >> _parent: aSystemManger [
	parent := aSystemManger
]

{ #category : 'environment' }
LcsSystem >> _restoreSystem [
	self suspendCurrentSystem.
	self
		restoreUnitOfWork;
		restoreSlotModel.
	self systemsManager currentSystem: self.
	self status: self newActiveState
]

{ #category : 'environment' }
LcsSystem >> _suspendSystem [
	(self slotDefinitionNamed: 'status') slotVarDirectlyPut: self newSuspendedState in: self.
	self
		releaseSlotModel;
		suspendUnitOfWork.
	self systemsManager currentSystem: nil
]

{ #category : 'slot model' }
LcsSystem >> addClasses: classes to: collection [ 
	collection addAll: (classes reject: [ :each | each isDomainClass not ]).
]

{ #category : 'slot model' }
LcsSystem >> addDomainClassesFromSubmodulesTo: systemDomainClasses [
	self allSubmoduleClasses do: [ :eachModule | 
		self
			addClasses: (eachModule domainClassesInPackage)
			to: systemDomainClasses ]
]

{ #category : 'slot model' }
LcsSystem >> addToSlotModel: aSlotModel [
	self systemSlotModel addToSlotModel: aSlotModel
]

{ #category : 'slot model' }
LcsSystem >> allBootstrapDomainClasses [
	^ OrderedCollection new
		addAll: self systemBootstrapDomainClasses;
		addAll: self systemDomainClasses;
		yourself

]

{ #category : 'unit of work' }
LcsSystem >> applyChanges [
	^ self unitOfWork applyChanges
]

{ #category : 'slot model' }
LcsSystem >> buildSlotDefinitions [
	self buildSlotDefinitionsFor: self globalCollections copy
]

{ #category : 'slot model' }
LcsSystem >> buildSlotDefinitionsFor: aCollectionOfDomainClasses [
	aCollectionOfDomainClasses do: [ :eachDomainClass | 
		eachDomainClass initializeSlotModel.
		(self globalCollections includes: eachDomainClass) ifFalse: [
			self globalCollections add: eachDomainClass ] ]
]

{ #category : 'unit of work' }
LcsSystem >> clearUnitOfWork [
	^ self unitOfWork clearUnitOfWork
]

{ #category : 'validation' }
LcsSystem >> configurationValidator [
	^ LcsSystemConfigurationValidator new
		validate: self;
		yourself
]

{ #category : 'unit of work' }
LcsSystem >> currentUnitOfWork [
	^ self _parent currentUnitOfWork
]

{ #category : 'security' }
LcsSystem >> currentUser [
	^ self securityModule currentUser
]

{ #category : 'accessing' }
LcsSystem >> globalCollections [
	^ self slotVarNamed: 'globalCollections' 
]

{ #category : 'accessing' }
LcsSystem >> globalCollections: anObject [
	self slotVarNamed: 'globalCollections' put: anObject
]

{ #category : 'gt views' }
LcsSystem >> gtAllSystemsFor: aView [
	<gtView>
	(LcsApplicationEnvironment isInActiveStatus)
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Systems';
		priority: 202;
		object: [ LcsApplicationEnvironment systemsManager ];
		view: #gtAllSystemsFor:;
		yourself
]

{ #category : 'gt views' }
LcsSystem >> gtConfigurationIssuesFor: aView [
	<gtView>
	self configurationValidator hasNoValidationIssues
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Configuration Issues';
		priority: 10;
		object: [ self configurationValidator ];
		view: #gtConfigurationIssuesFor:;
		yourself
]

{ #category : 'gt views' }
LcsSystem >> gtSystemSlotModelFor: aView [
	<gtView>
	"(self systemSlotModel isNil or: [self hasSystemSlotModels not])
		ifTrue: [ ^ aView empty ]."
	^ aView forward
		title: 'System Slot Model';
		priority: 201;
		object: [ self systemSlotModel ];
		view: #gtSystemSlotModelFor:;
		yourself
]

{ #category : 'gt views' }
LcsSystem >> gtUnitOfWorkFor: aView [
	<gtView>
	self slotModel ifNil: [
		^ aView text
			title: 'Unit Of Work';
			priority: 34;
			text: [ 'System Is Not Active' ]].

				self currentUnitOfWork isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Unit Of Work';
		priority: 34;
		object: [ self relatedUnitOfWork ];
		view: #gtUnitOfWorkFor:;
		yourself
]

{ #category : 'testing' }
LcsSystem >> hasSlotModel [
	^ self class hasSlotModel
]

{ #category : 'testing' }
LcsSystem >> hasSlotModelFor: aClass [
	^ self systemSlotModel hasSlotModelForClass: aClass
]

{ #category : 'testing' }
LcsSystem >> hasSystemSlotModels [
	^ self systemSlotModel hasSlotModels
]

{ #category : 'testing' }
LcsSystem >> hasValidConfiguration [
	^ self configurationValidator hasNoValidationIssues
]

{ #category : 'initialize' }
LcsSystem >> initialize [
	self makeCurrentSystem.
	self inititalizeSlotModel.
	super initialize.
	self currentUnitOfWork applyChanges
]

{ #category : 'initialize' }
LcsSystem >> initializeBasicSystem [
	self instantiateAndInstallSlotModelForBootstrapClasses.
	self unitOfWork addObject: self.

	(self slotDefinitionNamed: 'uuidGenerator') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'status') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'systemSlotModel') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'modules') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'moduleName') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'uuid') initializeSlotValueIn: self.
	self systemBootstrapDomainClasses
		do: [ :eachDomainClass | self addToSlotModel: eachDomainClass slotModel ].
	self addToSlotModel: self slotModel
]

{ #category : 'initialize' }
LcsSystem >> initializeModel [
	self modules isNil ifTrue: [ self initializeModulesVariable ].
	self systemSlotModel isNil ifTrue: [ self initializeSystemSlotModelVariable ].
	self buildModules.
	self initializeUninitializedSlotValues.
	"self modules initializeModel"
]

{ #category : 'initialize' }
LcsSystem >> initializeModulesVariable [
	self modulesSlot initializeSlotValueIn: self
]

{ #category : 'initialize' }
LcsSystem >> initializeSystemSlotModelVariable [
	self systemSlotModelSlot initializeSlotValueIn: self
]

{ #category : 'initialize' }
LcsSystem >> inititalizeSlotModel [
	self initializeBasicSystem.
	self addToSlotModel: self slotModel.
	self inititalizeSlotModelFor: self systemDomainClasses
]

{ #category : 'initialize' }
LcsSystem >> inititalizeSlotModelFor: aCollection [
	self inititalizeSlotModelFor: aCollection instantiateBlock: [ :eachClass |
		eachClass instantiateSlotModelInSystem: self ]
]

{ #category : 'initialize' }
LcsSystem >> inititalizeSlotModelFor: aDomainClassesCollection instantiateBlock: aBlock [
	aDomainClassesCollection do: aBlock.
	self verifySlotModelConsistencyFor: aDomainClassesCollection.
	self installSlotDefinitionsIn: aDomainClassesCollection
]

{ #category : 'initialize' }
LcsSystem >> installSlotDefinitionsIn: aDomainClassesCollection [
	aDomainClassesCollection do: [ :eachClass | eachClass installSlotDefinitions ]
]

{ #category : 'initialize' }
LcsSystem >> installSlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		do: [ :eachClass | eachClass installSlotDefinitions ]
]

{ #category : 'initialize' }
LcsSystem >> instantiateAndInstallSlotModelForBootstrapClasses [
	self instantiateSlotModelForBootstrapClasses.
	self verifySlotModelForBootstrapClasses.
	self installSlotModelForBootstrapClasses
]

{ #category : 'initialize' }
LcsSystem >> instantiateSlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		doWithIndex: [ :eachClass :index | 
			eachClass instantiateSlotModel.
			self assert: eachClass slotModel parent == eachClass ]
]

{ #category : 'testing' }
LcsSystem >> isApplicationSystem [
	^ true
]

{ #category : 'testing' }
LcsSystem >> isDemoSystem [
	^ false
]

{ #category : 'testing' }
LcsSystem >> isInActiveStatus [
	self hasSlotModel ifFalse: [ ^ false ].
	^ self status isInActiveStatus
]

{ #category : 'testing' }
LcsSystem >> isInSuspendedStatus [
	self hasSlotModel ifFalse: [ ^ true ].
	^ self status isInSuspendedStatus
]

{ #category : 'testing' }
LcsSystem >> isIncludedInSystemDomainClasses: aDomainClass [
	^ self globalCollections includes: aDomainClass class
]

{ #category : 'testing' }
LcsSystem >> isPrototypeSystem [
	^ false
]

{ #category : 'environment' }
LcsSystem >> makeCurrentSystem [
	LcsApplicationEnvironment systemsManager addSystem: self
]

{ #category : 'slot model' }
LcsSystem >> modulesSlot [
	^ self slotDefinitionNamed: 'modules'
]

{ #category : 'environment' }
LcsSystem >> newActiveState [
	^ LcsSystemActiveStatus new
		parent: self;
		yourself
]

{ #category : 'environment' }
LcsSystem >> newSuspendedState [
	^ LcsSystemSuspendedStatus new
		parent: self;
		yourself
]

{ #category : 'printing' }
LcsSystem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self statusNameString;
		nextPutAll: ')'
]

{ #category : 'unit of work' }
LcsSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : 'slot model' }
LcsSystem >> releaseSlotModel [
	self parent releaseSlotModel
]

{ #category : 'slot model' }
LcsSystem >> removeClassFromSlotModel: aDomainClass [
	self systemSlotModel removeClassFromSlotModel: aDomainClass
]

{ #category : 'slot model' }
LcsSystem >> removeFromSlotModel: aSlotDefinitions [
	self systemSlotModel removeFromSlotModel: aSlotDefinitions
]

{ #category : 'remove' }
LcsSystem >> removeSystem [ 
	self _parent removeSystem: self
]

{ #category : 'restore' }
LcsSystem >> restoreSlotModel [
	self systemSlotModel restoreSlotModel
]

{ #category : 'restore' }
LcsSystem >> restoreSystem [
	self _restoreSystem
]

{ #category : 'restore' }
LcsSystem >> restoreUnitOfWork [
	self systemsManager restoreUnitOfWorkFor: self
]

{ #category : 'modules' }
LcsSystem >> securityModule [
	^ self _moduleNamed: 'Security Module'
]

{ #category : 'accessing' }
LcsSystem >> status [
	^ self hasSlotModel 
		ifTrue: [ self slotVarNamed: 'status' ]
		ifFalse: [ self instVarNamed: 'status' ]
]

{ #category : 'accessing' }
LcsSystem >> status: aSystemStatus [ 
	self slotVarNamed: 'status' put: aSystemStatus
]

{ #category : 'asking' }
LcsSystem >> statusNameString [
	^ ([ self status ] on: Error do: [ :s | s return: nil ]) 
		ifNil: [ 'no status' ] 
		ifNotNil: [ self status statusName ]
]

{ #category : 'suspend' }
LcsSystem >> suspendCurrentSystem [
	self systemsManager suspendCurrentSystem
]

{ #category : 'suspend' }
LcsSystem >> suspendSystem [
	self status suspendSystem
]

{ #category : 'suspend' }
LcsSystem >> suspendUnitOfWork [
	self systemsManager suspendUnitOfWorkFor: self
]

{ #category : 'configuration' }
LcsSystem >> systemBootstrapDomainClasses [
	^ self class systemBootstrapDomainClasses
]

{ #category : 'slot model' }
LcsSystem >> systemDomainClasses [
	| systemDomainClasses |
	systemDomainClasses := OrderedCollection new.
	systemDomainClasses
		add: LcsGlobalCollections;
		add: LcsModules;
		add: LcsBaseConfiguration;
		add: LcsValueObject;
		add: LcsSingletonValueObject;
		add: LcsValueObjects;
		add: #LcsStateMachine asClass;
		add: #LcsStateMachineObject asClass;
		addAll: #LcsStateMachineObject asClass allSubclasses;
		add: #LcsStateMachineEvent asClass;
		add: #LcsStateMachineStates asClass;
		add: #LcsStateMachineTransitions asClass.
	self addDomainClassesFromSubmodulesTo: systemDomainClasses.
	^ systemDomainClasses
]

{ #category : 'accessing' }
LcsSystem >> systemSlotModel [
	^ systemSlotModel
]

{ #category : 'accessing' }
LcsSystem >> systemSlotModel: anObject [
	systemSlotModel := anObject
]

{ #category : 'slot model' }
LcsSystem >> systemSlotModelSlot [
	^ self slotDefinitionNamed: 'systemSlotModel'
]

{ #category : 'accessing' }
LcsSystem >> systemsManager [
	^ self _parent
]

{ #category : 'accessing' }
LcsSystem >> systemsManager: aSystemManager [
	self _parent: aSystemManager
]

{ #category : 'environment' }
LcsSystem >> toggleActionButtonLabel [
	^ self status toggleActionButtonLabel
]

{ #category : 'command' }
LcsSystem >> toggleStatus [
	self status toggleStatus
]

{ #category : 'unit of work' }
LcsSystem >> unitOfWork [
	^ self currentUnitOfWork
]

{ #category : 'accessing' }
LcsSystem >> uuidGenerator [
	^ self slotVarNamed: 'uuidGenerator'
]

{ #category : 'accessing' }
LcsSystem >> uuidGenerator: anObject [
	self slotVarNamed: 'uuidGenerator' put: anObject
]

{ #category : 'initialize' }
LcsSystem >> verifySlotModelConsistencyFor: aDomainClassesCollection [
	aDomainClassesCollection
		do: [ :eachClass | eachClass verifySlotModelConsistency ]
]

{ #category : 'initialize' }
LcsSystem >> verifySlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		doWithIndex: [ :eachClass :index | eachClass verifySlotModelConsistency ]
]
