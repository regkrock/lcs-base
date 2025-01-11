"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'status',
		'systemSlotModel',
		'globalCollections'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot definition' }
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

{ #category : #'slot model' }
LcsBaseSystem class >> prebootstrapDomainClasses [
	| prebootstrapClasses |
	prebootstrapClasses := OrderedCollection new.
	self addMyDomainClassHeirarchyTo: prebootstrapClasses.
	^ prebootstrapClasses
		add: LcsSystemSlotModel;
		add: LcsBaseSystemStatus;
		addAll: LcsBaseSystemStatus subclasses;
		yourself
]

{ #category : #'slot definition' }
LcsBaseSystem class >> statusSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'status';
		addSlotType: LcsBaseSystemStatus;
		initialValueBlock: [ LcsSystemActiveStatus new];
		yourself
]

{ #category : #'slot definition' }
LcsBaseSystem class >> systemSlotModelSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'systemSlotModel';
		addSlotType: LcsSystemSlotModel;
		addCollectionMemberType: LcsSlotModel;
		yourself
]

{ #category : #accessing }
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
		restoreSlotModel;
		status: LcsSystemActiveStatus new.
	self systemManager currentSystem: self
]

{ #category : #environment }
LcsBaseSystem >> _suspendSystem [ 
	(self slotDefinitionNamed: 'status') setPersistedValueTo: LcsSystemSuspendedStatus new in: self.
		
	self
		releaseSlotModel;
		suspendUnitOfWork.
		
	self systemManager currentSystem: nil
]

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotModel [
	self systemSlotModel addToSlotModel: aSlotModel
]

{ #category : #'slot model' }
LcsBaseSystem >> allBootstrapDomainClasses [
	^ OrderedCollection new
		addAll: self prebootstrapDomainClasses;
		add: self;
		addAll: self bootstrapDomainClasses;
		yourself

]

{ #category : #'unit of work' }
LcsBaseSystem >> applyChanges [
	^ self unitOfWork applyChanges
]

{ #category : #'slot model' }
LcsBaseSystem >> bootstrapDomainClasses [
	^OrderedCollection new
		"add: LcsDomainObject;
		add: LcsBaseModule;
		add: LcsBaseSystem;
		add: LcsSystemSlotModel;"
		add: LcsModule;
		add: LcsDomainCollection;
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
		add: #LcsStateMachineTransitions asClass;
		yourself
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
	^ self parent currentUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem >> globalCollections [
	^ self getValueOfSlotNamed: 'globalCollections' 
]

{ #category : #accessing }
LcsBaseSystem >> globalCollections: anObject [
	self setValueOfSlotNamed: 'globalCollections' to: anObject
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

{ #category : #'gt view' }
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

{ #category : #'slot model' }
LcsBaseSystem >> initialSystemDomainClasses [
	^ self requiredSystemDomainClasses
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
	self inititalizeSlotModelFor: self prebootstrapDomainClasses instantiateBlock:	[ :eachClass |
		eachClass  instantiateSlotModel ]. .

	self unitOfWork addObject: self.
	
	(self slotDefinitionNamed: 'status') initializeSlotValueIn: self.
	(self slotDefinitionNamed: 'systemSlotModel') initializeSlotValueIn: self.
	self prebootstrapDomainClasses do: [ :eachDomainClass | 
		self addToSlotModel: eachDomainClass slotModel ]
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
	self inititalizeSlotModelFor: self bootstrapDomainClasses
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
	aDomainClassesCollection do: [ :eachClass |
		eachClass  verifySlotModelConsistency ]. 
	aDomainClassesCollection do: [ :eachClass |
		eachClass  installSlotDefinitions ]
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

{ #category : #initialize }
LcsBaseSystem >> makeCurrentSystem [
	LcsApplicationEnvironment systemManager addSystem: self
]

{ #category : #'slot model' }
LcsBaseSystem >> modulesSlot [
	^ self slotDefinitionNamed: 'modules'
]

{ #category : #initialize }
LcsBaseSystem >> prebootstrapDomainClasses [
	^ self class prebootstrapDomainClasses
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

{ #category : #'slot model' }
LcsBaseSystem >> requiredSystemDomainClasses [
	^OrderedCollection new
		addAll: self baseDomainModelClasses;
		add: self class;
		addAll: self submoduleClasses;
		yourself
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

{ #category : #accessing }
LcsBaseSystem >> status [
	^ self getValueOfSlotNamed: 'status'
]

{ #category : #accessing }
LcsBaseSystem >> status: aSystemStatus [ 
	self setValueOfSlotNamed: 'status' to: aSystemStatus
]

{ #category : #asking }
LcsBaseSystem >> statusNameString [
	^ self status ifNil: [ 'no status' ] ifNotNil: [ self status statusName ]
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
