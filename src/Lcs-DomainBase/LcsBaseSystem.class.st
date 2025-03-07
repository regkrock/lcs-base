"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'status',
		'systemSlotModel',
		'globalCollections',
		'uuidGenerator'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'system model' }
LcsBaseSystem class >> addMyDomainClassHeirarchyTo: prebootstrapClasses [
	self allClassBetweenMyselfAndLcsDomainObject
		do: [ :each | (prebootstrapClasses includes: each) ifFalse: [ prebootstrapClasses add: each ] ].
	prebootstrapClasses add: self.
	prebootstrapClasses addAll: self allSubmoduleClasses
]

{ #category : #'slot definitions' }
LcsBaseSystem class >> globalCollectionsSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'globalCollections';
		addSlotType: LcsGlobalCollections;
		addCollectionMemberType: LcsDomainCollection;
		yourself
]

{ #category : #testing }
LcsBaseSystem class >> isApplicationSystemClass [
	^ true
]

{ #category : #configuration }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #'instance creation' }
LcsBaseSystem class >> new [
	"A factory pattern is used here. The creation of the system is delegated to the system manager"
	^ self basicNew
		initialize;
		yourself
]

{ #category : #'slot definitions' }
LcsBaseSystem class >> statusSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'status';
		addSlotType: LcsBaseSystemStatus;
		initialValueBlock: [ :domainParent | LcsSystemActiveStatus new];
		yourself
]

{ #category : #configuration }
LcsBaseSystem class >> systemBootstrapDomainClasses [
	| prebootstrapClasses |
	prebootstrapClasses := 
		OrderedCollection new
			add: LcsBaseDomainObject;
			add: LcsSupportDomainObject;
			add: LcsDomainObject;
			add: LcsDomainCollection;
			add: LcsDomainObjectHistory;
			add: LcsDomainObjectChangeRecord;
			add: LcsDomainObjectChangeRecords;
			add: LcsDomainObjectSlotChange;
			add: LcsDomainObjectSlotChanges;
			add: LcsSystemSlotModel;
			add: LcsBaseSystemStatus;
			addAll: LcsBaseSystemStatus subclasses;
			add: LcsModules;
			yourself.
	self addMyDomainClassHeirarchyTo: prebootstrapClasses.
	^ prebootstrapClasses
]

{ #category : #'system model' }
LcsBaseSystem class >> systemSlotModelSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'systemSlotModel';
		addSlotType: LcsSystemSlotModel;
		addCollectionMemberType: LcsSlotModel;
		yourself
]

{ #category : #'slot definitions' }
LcsBaseSystem class >> uuidGeneratorSlotDefinition [
	<slotDefinition>
	^ LcsUuidGeneratorSlot new
]

{ #category : #security }
LcsBaseSystem >> _parent [
	"Do not use in normal situations"
	^ parent
]

{ #category : #accessing }
LcsBaseSystem >> _parent: aSystemManger [
	parent := aSystemManger
]

{ #category : #environment }
LcsBaseSystem >> _restoreSystem [
	self suspendCurrentSystem.
	self
		restoreUnitOfWork;
		restoreSlotModel.
	self systemManager currentSystem: self.
	self status: self newActiveState
]

{ #category : #environment }
LcsBaseSystem >> _suspendSystem [
	(self slotDefinitionNamed: 'status') slotVarDirectlyPut: self newSuspendedState in: self.
	self
		releaseSlotModel;
		suspendUnitOfWork.
	self systemManager currentSystem: nil
]

{ #category : #'slot model' }
LcsBaseSystem >> addClasses: classes to: collection [ 
	collection addAll: (classes reject: [ :each | each isDomainClass not ]).
]

{ #category : #'slot model' }
LcsBaseSystem >> addDomainClassesFromSubmodulesTo: systemDomainClasses [
	self allSubmoduleClasses do: [ :eachModule | 
		self
			addClasses: (eachModule package classes reject: [ :each | each isMeta ])
			to: systemDomainClasses ]
]

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotModel [
	self systemSlotModel addToSlotModel: aSlotModel
]

{ #category : #'slot model' }
LcsBaseSystem >> allBootstrapDomainClasses [
	^ OrderedCollection new
		addAll: self systemBootstrapDomainClasses;
		addAll: self systemDomainClasses;
		yourself

]

{ #category : #'unit of work' }
LcsBaseSystem >> applyChanges [
	^ self unitOfWork applyChanges
]

{ #category : #'slot model' }
LcsBaseSystem >> buildSlotDefinitions [
	self buildSlotDefinitionsFor: self globalCollections copy
]

{ #category : #'slot model' }
LcsBaseSystem >> buildSlotDefinitionsFor: aCollectionOfDomainClasses [
	aCollectionOfDomainClasses do: [ :eachDomainClass | 
		eachDomainClass initializeSlotModel.
		(self globalCollections includes: eachDomainClass) ifFalse: [
			self globalCollections add: eachDomainClass ] ]
]

{ #category : #validation }
LcsBaseSystem >> configurationValidator [
	^ LcsSystemConfigurationValidator new
		validate: self;
		yourself
]

{ #category : #'unit of work' }
LcsBaseSystem >> currentUnitOfWork [
	^ self _parent currentUnitOfWork
]

{ #category : #security }
LcsBaseSystem >> currentUser [
	^ self securityModule currentUser
]

{ #category : #accessing }
LcsBaseSystem >> globalCollections [
	^ self slotVarNamed: 'globalCollections' 
]

{ #category : #accessing }
LcsBaseSystem >> globalCollections: anObject [
	self slotVarNamed: 'globalCollections' put: anObject
]

{ #category : #'slot model' }
LcsBaseSystem >> gtAllSystemsFor: aView [
	<gtView>
	(LcsApplicationEnvironment isInActiveStatus)
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Systems';
		priority: 50;
		object: [ LcsApplicationEnvironment systemManager ];
		view: #gtAllSystemsFor:;
		yourself
]

{ #category : #'gt views' }
LcsBaseSystem >> gtConfigurationIssuesFor: aView [
	<gtView>
	self configurationValidator hasNoValidationIssues
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Configuration Issues';
		priority: 1;
		object: [ self configurationValidator ];
		view: #gtConfigurationIssuesFor:;
		yourself
]

{ #category : #'slot model' }
LcsBaseSystem >> gtSystemSlotModelFor: aView [
	<gtView>
	(self systemSlotModel isNil or: [self hasSystemSlotModels not])
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'System Slot Model';
		priority: 1;
		object: [ self systemSlotModel ];
		view: #gtSystemSlotModelFor:;
		yourself
]

{ #category : #'slot model' }
LcsBaseSystem >> gtUnitOfWorkFor: aView [
	<gtView>
	self slotModel isNil ifTrue: [ ^ aView empty ].
	self currentUnitOfWork isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Unit Of Work';
		priority: 2;
		object: [ self relatedUnitOfWork ];
		view: #gtUnitOfWorkFor:;
		yourself
]

{ #category : #testing }
LcsBaseSystem >> hasSlotModel [
	^ self class hasSlotModel
]

{ #category : #testing }
LcsBaseSystem >> hasSlotModelFor: aClass [
	^ self systemSlotModel hasSlotModelForClass: aClass
]

{ #category : #testing }
LcsBaseSystem >> hasSystemSlotModels [
	^ self systemSlotModel hasSlotModels
]

{ #category : #testing }
LcsBaseSystem >> hasValidConfiguration [
	^ self configurationValidator hasNoValidationIssues
]

{ #category : #initialize }
LcsBaseSystem >> initialize [
	self makeCurrentSystem.
	self inititalizeSlotModel.
	super initialize.
	self currentUnitOfWork applyChanges
]

{ #category : #initialize }
LcsBaseSystem >> initializeBasicSystem [
	self instantiateAndInstallSlotModelForBootstrapClasses.
	self unitOfWork addObject: self.

	(self slotDefinitionNamed: 'uuidGenerator') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'status') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'systemSlotModel') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'modules') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'uuid') initializeSlotValueIn: self.
	self systemBootstrapDomainClasses
		do: [ :eachDomainClass | self addToSlotModel: eachDomainClass slotModel ].
	self addToSlotModel: self slotModel
]

{ #category : #initialize }
LcsBaseSystem >> initializeModel [
	self modules isNil ifTrue: [ self initializeModulesVariable ].
	self systemSlotModel isNil ifTrue: [ self initializeSystemSlotModelVariable ].
	self buildModules.
	self initializeUninitializedSlotValues.
	"self modules initializeModel"
]

{ #category : #initialize }
LcsBaseSystem >> initializeModulesVariable [
	self modulesSlot initializeSlotValueIn: self
]

{ #category : #initialize }
LcsBaseSystem >> initializeSystemSlotModelVariable [
	self systemSlotModelSlot initializeSlotValueIn: self
]

{ #category : #initialize }
LcsBaseSystem >> inititalizeSlotModel [
	self initializeBasicSystem.
	self addToSlotModel: self slotModel.
	self inititalizeSlotModelFor: self systemDomainClasses
]

{ #category : #initialize }
LcsBaseSystem >> inititalizeSlotModelFor: aCollection [
	self inititalizeSlotModelFor: aCollection instantiateBlock: [ :eachClass |
		eachClass instantiateSlotModel.
		self addToSlotModel: eachClass slotModel]
]

{ #category : #initialize }
LcsBaseSystem >> inititalizeSlotModelFor: aDomainClassesCollection instantiateBlock: aBlock [
	aDomainClassesCollection do: aBlock.
	self verifySlotModelConsistencyFor: aDomainClassesCollection.
	self installSlotDefinitionsIn: aDomainClassesCollection
]

{ #category : #initialize }
LcsBaseSystem >> installSlotDefinitionsIn: aDomainClassesCollection [
	aDomainClassesCollection do: [ :eachClass | eachClass installSlotDefinitions ]
]

{ #category : #initialize }
LcsBaseSystem >> installSlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		doWithIndex: [ :eachClass :index | eachClass installSlotDefinitions ]
]

{ #category : #initialize }
LcsBaseSystem >> instantiateAndInstallSlotModelForBootstrapClasses [
	self instantiateSlotModelForBootstrapClasses.
	self verifySlotModelForBootstrapClasses.
	self installSlotModelForBootstrapClasses
]

{ #category : #initialize }
LcsBaseSystem >> instantiateSlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		doWithIndex: [ :eachClass :index | 
			eachClass instantiateSlotModel.
			self assert: eachClass slotModel parent == eachClass ]
]

{ #category : #testing }
LcsBaseSystem >> isApplicationSystem [
	^ true
]

{ #category : #testing }
LcsBaseSystem >> isIncludedInSystemDomainClasses: aDomainClass [
	^ self globalCollections includes: aDomainClass class
]

{ #category : #testing }
LcsBaseSystem >> isPrototypeSystem [
	^ false
]

{ #category : #environment }
LcsBaseSystem >> makeCurrentSystem [
	LcsApplicationEnvironment systemManager addSystem: self
]

{ #category : #'slot model' }
LcsBaseSystem >> modulesSlot [
	^ self slotDefinitionNamed: 'modules'
]

{ #category : #environment }
LcsBaseSystem >> newActiveState [
	^ LcsSystemActiveStatus new
		parent: self;
		yourself
]

{ #category : #environment }
LcsBaseSystem >> newSuspendedState [
	^ LcsSystemSuspendedStatus new
		parent: self;
		yourself
]

{ #category : #printing }
LcsBaseSystem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self statusNameString;
		nextPutAll: ')'
]

{ #category : #'unit of work' }
LcsBaseSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : #'slot model' }
LcsBaseSystem >> releaseSlotModel [
	self parent releaseSlotModel
]

{ #category : #'slot model' }
LcsBaseSystem >> removeClassFromSlotModel: aDomainClass [
	self systemSlotModel removeClassFromSlotModel: aDomainClass
]

{ #category : #'slot model' }
LcsBaseSystem >> removeFromSlotModel: aSlotDefinitions [
	self systemSlotModel removeFromSlotModel: aSlotDefinitions
]

{ #category : #remove }
LcsBaseSystem >> removeSystem [ 
	self _parent removeSystem: self
]

{ #category : #restore }
LcsBaseSystem >> restoreSlotModel [
	self systemSlotModel restoreSlotModel
]

{ #category : #restore }
LcsBaseSystem >> restoreSystem [
	self _restoreSystem
]

{ #category : #restore }
LcsBaseSystem >> restoreUnitOfWork [
	self systemManager restoreUnitOfWorkFor: self
]

{ #category : #modules }
LcsBaseSystem >> securityModule [
	^ self moduleNamed: 'Security Module'
]

{ #category : #accessing }
LcsBaseSystem >> status [
	^ self hasSlotModel 
		ifTrue: [^ self slotVarNamed: 'status' ]
		ifFalse: [ self instVarNamed: 'status' ]
]

{ #category : #accessing }
LcsBaseSystem >> status: aSystemStatus [ 
	self slotVarNamed: 'status' put: aSystemStatus
]

{ #category : #asking }
LcsBaseSystem >> statusNameString [
	^ ([ self status ] on: Error do: [ :s | s return: nil ]) 
		ifNil: [ 'no status' ] 
		ifNotNil: [ self status statusName ]
]

{ #category : #suspend }
LcsBaseSystem >> suspendCurrentSystem [
	self systemManager suspendCurrentSystem
]

{ #category : #suspend }
LcsBaseSystem >> suspendSystem [
	self status suspendSystem
]

{ #category : #suspend }
LcsBaseSystem >> suspendUnitOfWork [
	self systemManager suspendUnitOfWorkFor: self
]

{ #category : #configuration }
LcsBaseSystem >> systemBootstrapDomainClasses [
	^ self class systemBootstrapDomainClasses
]

{ #category : #'slot model' }
LcsBaseSystem >> systemDomainClasses [
	| systemDomainClasses |
	systemDomainClasses := OrderedCollection new.
	systemDomainClasses
		add: LcsModule;
		add: LcsGlobalCollections;
		add: LcsModules;
		add: LcsBaseConfiguration;
		add: LcsCode;
		add: LcsSingletonCode;
		add: LcsCodes;
		add: #LcsStateMachine asClass;
		add: #LcsStateMachineObject asClass;
		addAll: #LcsStateMachineObject asClass allSubclasses;
		add: #LcsStateMachineEvent asClass;
		add: #LcsStateMachineStates asClass;
		add: #LcsStateMachineTransitions asClass.
	self addDomainClassesFromSubmodulesTo: systemDomainClasses.
	^ systemDomainClasses
]

{ #category : #accessing }
LcsBaseSystem >> systemManager [
	^ self _parent
]

{ #category : #accessing }
LcsBaseSystem >> systemManager: aSystemManager [
	self _parent: aSystemManager
]

{ #category : #accessing }
LcsBaseSystem >> systemSlotModel [
	^ systemSlotModel
]

{ #category : #accessing }
LcsBaseSystem >> systemSlotModel: anObject [
	systemSlotModel := anObject
]

{ #category : #'slot model' }
LcsBaseSystem >> systemSlotModelSlot [
	^ self slotDefinitionNamed: 'systemSlotModel'
]

{ #category : #environment }
LcsBaseSystem >> toggleActionButtonLabel [
	^ self status toggleActionButtonLabel
]

{ #category : #command }
LcsBaseSystem >> toggleStatus [
	self status toggleStatus
]

{ #category : #'unit of work' }
LcsBaseSystem >> unitOfWork [
	^ self currentUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem >> uuidGenerator [
	^ self slotVarNamed: 'uuidGenerator'
]

{ #category : #accessing }
LcsBaseSystem >> uuidGenerator: anObject [
	self slotVarNamed: 'uuidGenerator' put: anObject
]

{ #category : #initialize }
LcsBaseSystem >> verifySlotModelConsistencyFor: aDomainClassesCollection [
	aDomainClassesCollection
		do: [ :eachClass | eachClass verifySlotModelConsistency ]
]

{ #category : #initialize }
LcsBaseSystem >> verifySlotModelForBootstrapClasses [
	self systemBootstrapDomainClasses
		doWithIndex: [ :eachClass :index | eachClass verifySlotModelConsistency ]
]
