"
This is testing with no system setup in the setup. 


Use this to test creating a prototype system.

To see the application environment click on: {{gtClass:LcsApplicationEnvironment}}


"
Class {
	#name : #LxxPrototypeSystemTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#instVars : [
		'system1',
		'system2',
		'newSystem',
		'additionalSubject'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #private }
LxxPrototypeSystemTest >> additionalNewPrototypeSystem [
	self addtionalSubject: LxxPrototypeSystem new
]

{ #category : #accessing }
LxxPrototypeSystemTest >> additionalSubject [
	^ additionalSubject
]

{ #category : #accessing }
LxxPrototypeSystemTest >> additionalSubject: anObject [
	additionalSubject := anObject 
]

{ #category : #private }
LxxPrototypeSystemTest >> addtionalSubject: anObject [ 
	additionalSubject := anObject
]

{ #category : #private }
LxxPrototypeSystemTest >> newPrototypeSystem [
	| numberOfSystems numberOfUnitsOfWork |
	self assert: LcsApplicationEnvironment isInActiveStatus.
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	
	self subject: LxxPrototypeSystem new.

	self assert: self currentSystem identicalTo: self subject.
	self assert: self currentUnitOfWork == self subject unitOfWork.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: self subject status isInActiveStatus.
	self assert: self subject status parent identicalTo: self subject.
	self assert: LcsDomainObject isSlotModelReleased not.
	self assert: (self subject systemSlotModel hasSlotModelFor: self subject).
	self assert: (self unitsOfWorkManager unitOfWorkFor: self subject) system identicalTo: self subject.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPrototypePersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration.

	self assert: LcsDomainObject isSlotModelReleased not
]

{ #category : #running }
LxxPrototypeSystemTest >> setUp [
	super setUp.
	self assert: self currentSystem isNil
]

{ #category : #running }
LxxPrototypeSystemTest >> tearDown [
	self subject ifNotNil: [ 
		self subject removeSystem.
		self subject: nil ].
	self additionalSubject ifNotNil: [ 
		self additionalSubject removeSystem.
		self additionalSubject: nil ].
	super tearDown

]

{ #category : #tests }
LxxPrototypeSystemTest >> testAddingNewDomainObjectToDomainCollection [
	| domainObject |
	self newPrototypeSystem.

	domainObject := LxxPrototypePerson new.
	self assert: (self subject persons pendingAdds includes: domainObject).
	self deny: (self subject persons includes: domainObject).
	
	self currentSystem applyChanges.
	self currentSystem currentUnitOfWork hasNoChanges.

	self assert: (self subject persons pendingAdds isEmpty).
	self assert: (self subject persons includes: domainObject).
	self assert: domainObject parent == self subject persons 
	

]

{ #category : #tests }
LxxPrototypeSystemTest >> testChangedSlotInDomainObject [
	| domainObject firstChangedDateOfBirth secondChangedDateOfBirth initialDateOfBirth |

	initialDateOfBirth := Date today.
	firstChangedDateOfBirth := Date newDay: 1 month: 1 year: 2000.
	secondChangedDateOfBirth := Date newDay: 1 month: 1 year: 2010.

	self newPrototypeSystem.

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
	self newPrototypeSystem.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := LcsDomainObject new.
	self assert: self currentSystem currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: self currentSystem currentUnitOfWork addedObjects any domainObject identicalTo: domainObject
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationNew [
	self newPrototypeSystem.
	self assert: self currentSystem identicalTo: self subject.
	self assert: (self subject moduleNamed: LxxPrototypePersonsModule moduleName) class name equals: #LxxPrototypePersonsModule.
	self assert: (self subject moduleNamed: LxxPrototype2Module moduleName) class equals: LxxPrototype2Module.
	self assert: self subject numberOfChildModules equals: 2. 
	self assert: (self subject moduleNamed: LxxPrototypePersonsModule moduleName) numberOfChildModules equals: 0.
	self assert: (self subject moduleNamed: LxxPrototype2Module moduleName) numberOfChildModules equals: 1.
	self assert: (self subject moduleNamed: LxxPrototype2Submodule moduleName) numberOfChildModules equals: 0.
	"self assert:system hasValidConfiguration. "
]

{ #category : #tests }
LxxPrototypeSystemTest >> testCreationOfNewSystem [
	self newPrototypeSystem.
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
	self newPrototypeSystem.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem identicalTo:self subject.
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
	self newPrototypeSystem.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : #tests }
LxxPrototypeSystemTest >> testPrototypeSystemCreation [
	| allDomainClasses |

	self newPrototypeSystem.
	self assert: self subject currentUnitOfWork hasNoChanges.
	self assert: (self subject slotDefinitionNamed: 'persons') notNil.
	self assert: self subject persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPrototypePerson slotModel hasSlotDefinitions.
	self assert: self subject configuration class equals: LxxPrototypeSystemConfiguration.
	self assert: self subject hasSystemSlotModels .
	self assert: self subject systemSlotModel slotModels size equals: self subject allBootstrapDomainClasses size.
	allDomainClasses := LcsDomainObject withAllSubclasses asOrderedCollection.
	self subject systemSlotModel slotModels keysDo: [ :each | allDomainClasses remove: each ifAbsent: [ ] ].
	self assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotModel isNil ])
]

{ #category : #tests }
LxxPrototypeSystemTest >> testRestoreSuspendedSystem [
	
	self newPrototypeSystem.

	self assert: self subject isInActiveStatus.
	self subject suspendSystem.
	self assert: self subject isInSuspendedStatus.

	self assert: self currentSystem isNil.
	
	self subject restoreSystem.
	self assert: self currentSystem == self subject.
	self assert: self currentSystem isInActiveStatus

]

{ #category : #tests }
LxxPrototypeSystemTest >> testSuspendAndRestoreBetweenTwoSystems [
	
	self newPrototypeSystem.
	self subject isInActiveStatus.

	self additionalNewPrototypeSystem.
	self assert: self subject isInSuspendedStatus.
	self assert: self additionalSubject isInActiveStatus.

	self additionalSubject suspendSystem.
	self assert: self subject isInSuspendedStatus.
	self assert: self additionalSubject isInSuspendedStatus.
	self assert: self currentSystem isNil.

	self additionalSubject restoreSystem.
	self assert: self additionalSubject isInActiveStatus.
	self assert: self subject isInSuspendedStatus


]

{ #category : #tests }
LxxPrototypeSystemTest >> testSuspendCurrentSystem [
	
	self newPrototypeSystem.

	self assert: self subject isInActiveStatus.
	self subject suspendSystem.
	self assert: self subject isInSuspendedStatus.

	self assert: self currentSystem isNil
	
	"self assert: self additionalSubject isInActiveStatus.

	self additionalSubject suspendSystem.
	self assert: self subject isInSuspendedStatus.
	self assert: self additionalSubject isInSuspendedStatus.

	self additionalSubject restoreSystem.
	self assert: self subject isInActiveStatus.
	self assert: self additionalSubject isInSuspendedStatus."

	"	LcsApplicationEnvironment suspendCurrentSystem.
	self assert: LcsDomainObject isSlotModelReleased.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: (self systemManager systems includes: self system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: self system1.
	self assert: self systemManager currentSystem identicalTo: self system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: self subject.
	self assert: LcsDomainObject isSlotModelReleased not."


]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemCreation [

	self newPrototypeSystem. 

	self assert: self subject identicalTo: self currentSystem
]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemRemoval [

	self newPrototypeSystem.
	self assert: self subject isInActiveStatus.

	LcsApplicationEnvironment removeCurrentSystem.
	
	self assert: self subject isInSuspendedStatus.

	self assert: self systemManager hasNoCurrentSystem.
	
	self assert: (self systemManager systems includes: self subject) not
]

{ #category : #tests }
LxxPrototypeSystemTest >> testSystemRemovalWhenTwoSystemsExist [

	self newPrototypeSystem.
	self additionalNewPrototypeSystem.
	self assert: self subject isInSuspendedStatus.
	self assert: self additionalSubject isInActiveStatus.
	
	LcsApplicationEnvironment removeCurrentSystem.
	
	self assert: self subject isInSuspendedStatus.

	self assert: self systemManager hasNoCurrentSystem.
	
	self assert: (self systemManager systems includes: self subject).
	self assert: (self systemManager systems includes: self additionalSubject) not.
	
	LcsApplicationEnvironment makeSystemCurrent: self subject.
	self assert: self subject isInActiveStatus.

]
