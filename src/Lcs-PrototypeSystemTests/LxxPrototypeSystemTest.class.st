Class {
	#name : #LxxPrototypeSystemTest,
	#superclass : #LcsNoExistingSetupSystemTest,
	#instVars : [
		'system1',
		'system2',
		'newSystem'
	],
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #private }
LxxPrototypeSystemTest >> newPrototypeSystem [
	| system numberOfSystems numberOfUnitsOfWork |
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	
	system := LxxPrototypeSystem new.

	self assert: self currentSystem identicalTo: system.
	self assert: self currentUnitOfWork == system unitOfWork.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: system status isInActiveStatus.
	self assert: system status parent identicalTo: system.
	self assert: LcsDomainObject isSlotModelReleased not.
	self assert: (system systemSlotModel hasSlotModelFor: system).
	self assert: (self unitsOfWorkManager unitOfWorkFor: system) system identicalTo: system.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.
	"self assert: self system1 hasValidConfiguration."

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPrototypePersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration.

	self assert: LcsDomainObject isSlotModelReleased not.
	
	^ system
]

{ #category : #'as yet unclassified' }
LxxPrototypeSystemTest >> setUp [
	super setUp.
	self assert: self currentSystem isNil
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system1 [
	^ system1
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system1: anObject [
	^ system1 := anObject
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system2 [
	^ system2
]

{ #category : #accessing }
LxxPrototypeSystemTest >> system2: anObject [
	^ system2 := anObject
]

{ #category : #running }
LxxPrototypeSystemTest >> tearDown [
	self system1 ifNotNil: [ 
		self system1 removeSystem.
		self system1: nil ].
	self system2 ifNotNil: [ 
		self system2 removeSystem.
		self system2: nil ].
	super tearDown

]

{ #category : #tests }
LxxPrototypeSystemTest >> testAddingNewDomainObjectToDomainCollection [
	| domainObject |
	self system1: self newPrototypeSystem.

	domainObject := LxxPrototypePerson new.
	self assert: (self system1 persons pendingAdds includes: domainObject).
	self deny: (self system1 persons includes: domainObject).
	
	self currentSystem applyChanges.
	self currentSystem currentUnitOfWork hasNoChanges.

	self assert: (self system1 persons pendingAdds isEmpty).
	self assert: (self system1 persons includes: domainObject).
	self assert: domainObject parent == self system1 persons 
	

]

{ #category : #tests }
LxxPrototypeSystemTest >> testChangedSlotInDomainObject [
	| domainObject firstChangedDateOfBirth secondChangedDateOfBirth initialDateOfBirth |

	initialDateOfBirth := Date today.
	firstChangedDateOfBirth := Date newDay: 1 month: 1 year: 2000.
	secondChangedDateOfBirth := Date newDay: 1 month: 1 year: 2010.

	self system1: self newPrototypeSystem.

	domainObject := LxxPrototypePerson new.
	"Test initial date of birth when new person is created"
	self assert: domainObject dateOfBirth equals: initialDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = initialDateOfBirth.

	"Changed date of birth before applying the changes"
	domainObject dateOfBirth: firstChangedDateOfBirth.
	self assert: domainObject dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentSystem applyChanges.
	
	"After applying the changes, now change the date of birth again"
	self assert: domainObject dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	domainObject dateOfBirth: secondChangedDateOfBirth.
	self assert: domainObject dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = secondChangedDateOfBirth.

]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreatingNewDomainObject [
	| domainObject |
	self system1: self newPrototypeSystem.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := self domainObjectClass new.
	self assert: self currentSystem currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: self currentSystem currentUnitOfWork addedObjects any domainObject identicalTo: domainObject
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationNew [
	| system |
	system := self newPrototypeSystem.
	self assert: self currentSystem identicalTo: system.
	self assert: (system moduleNamed: LxxPrototypePersonsModule moduleName) class name equals: #LxxPrototypePersonsModule.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) class equals: LxxPrototype2Module.
	self assert: system numberOfChildModules equals: 2. 
	self assert: (system moduleNamed: LxxPrototypePersonsModule moduleName) numberOfChildModules equals: 0.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) numberOfChildModules equals: 1.
	self assert: (system moduleNamed: LxxPrototype2Submodule moduleName) numberOfChildModules equals: 0.
	"self assert:system hasValidConfiguration. "
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationOfNewSystem [
	self system1: self newPrototypeSystem.
	self assert: self currentSystem class identicalTo: LxxPrototypeSystem.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPrototypePersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class equals: LxxPrototypeSystemConfiguration
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationWithPrototypeSystem [
	| domainObject |
	self system1: self newPrototypeSystem.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem identicalTo:self system1.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject identicalTo: domainObject.
	self assert: domainObject slotModel className equals: 'LcsSlotModel' .
]

{ #category : #tests }
LxxPrototypeSystemTest >> testInstallingFirstNameSlotInPerson [
	self deny: (LxxPrototypePerson instVarNames includes: 'firstName').
	self deny: (LxxPrototypePerson respondsTo: #firstName).
	self deny: (LxxPrototypePerson respondsTo: #firstName:).
	self deny: (LxxPrototypePerson class respondsTo: #firstNameSlotDefinition).
]

{ #category : #tests }
LxxPrototypeSystemTest >> testNewUnitOfWorkInSystem [
	self system1: self newPrototypeSystem.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : #tests }
LxxPrototypeSystemTest >> testPrototypeSystemCreation [
	| allDomainClasses |

	self system1: self newPrototypeSystem.
	self assert: self system1 currentUnitOfWork hasNoChanges.
	self assert: (self system1 slotDefinitionNamed: 'persons') notNil.
	self assert: self system1 persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self system1 configuration class equals: LxxPrototypeSystemConfiguration.
	self assert: self system1 hasSystemSlotModels .
	self assert: self system1 systemSlotModel slotModels size equals: self system1 allBootstrapDomainClasses size.
	allDomainClasses := self domainObjectClass withAllSubclasses asOrderedCollection.
	self system1 systemSlotModel slotModels keysDo: [ :each | allDomainClasses remove: each ifAbsent: [ ] ].
	self assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotModel isNil ])
]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemCreation [

	self system1: self newPrototypeSystem. 

	self assert: self system1 identicalTo: self currentSystem
]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemRemoval [

	self system1: self newPrototypeSystem.
	self system2:self newPrototypeSystem.
	self assert: self system1 isInSuspendedStatus.
	self assert: self system2 isInActiveStatus.
	
	LcsApplicationEnvironment removeCurrentSystem.
	
	self assert: self system1 isInSuspendedStatus.

	self assert: self systemManager hasNoCurrentSystem.
	
	self assert: (self systemManager systems includes: self system1).
	self assert: (self systemManager systems includes: self system2) not.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self system1 isInActiveStatus.

]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemSuspend [
	
	self system1: self newPrototypeSystem.
	self assert: self system1 isInActiveStatus.

	self system2: self newPrototypeSystem.
	self assert: self system1 isInSuspendedStatus.
	self assert: self system2 isInActiveStatus.

	self system2 suspendSystem.
	self assert: self system1 isInSuspendedStatus.
	self assert: self system2 isInSuspendedStatus.

	self system1 restoreSystem.
	self assert: self system1 isInActiveStatus.
	self assert: self system2 isInSuspendedStatus.

	"	LcsApplicationEnvironment suspendCurrentSystem.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self system1.
	self assert: LcsDomainObject isSlotModelReleased not.
"


]
