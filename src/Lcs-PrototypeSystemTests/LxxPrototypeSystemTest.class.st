"
This is testing with no system setup in the setup. 


Use this to test creating a prototype system.

To see the application environment click on: {{gtClass:LcsApplicationEnvironment}}


"
Class {
	#name : 'LxxPrototypeSystemTest',
	#superclass : 'LcsTestWithNoTestSystemSetupForTest',
	#instVars : [
		'system1',
		'system2',
		'newSystem'
	],
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'private' }
LxxPrototypeSystemTest >> additionalNewPrototypeSystem [
	self additionalSubject: LxxPrototypeSystem new
]

{ #category : 'private' }
LxxPrototypeSystemTest >> bootstrapClasses [
	^ self subject allBootstrapDomainClasses
		asSortedCollection: [ :a :b | a name <= b name ]
]

{ #category : 'private' }
LxxPrototypeSystemTest >> classesWithInitializeSlotModel [
	^ self subject systemSlotModel slotModels keys
		asSortedCollection: [ :a :b | a name <= b name ]
]

{ #category : 'private' }
LxxPrototypeSystemTest >> newPrototypeSystem [
	| numberOfSystems numberOfUnitsOfWork |
	self assert: LcsApplicationEnvironment isInActiveStatus.
	numberOfSystems := self systemsManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	
	self subject: LxxPrototypeSystem new.

	self assert: self currentSystem identicalTo: self subject.
	self assert: self currentUnitOfWork == self subject unitOfWork.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: self subject status isInActiveStatus.
	self assert: self subject status parent identicalTo: self subject.
	self assert: LcsBaseDomainObject isSlotModelReleased not.
	self assert: (self subject systemSlotModel hasSlotModelFor: self subject).
	self assert: (self unitsOfWorkManager unitOfWorkFor: self subject) system identicalTo: self subject.
	self assert: self systemsManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.

	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
		
	self assert: LxxPerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class name equals: #LxxPrototypeSystemConfiguration.

	self assert: LcsBaseDomainObject isSlotModelReleased not.
	self assert: self subject moduleName equals: LxxPrototypeSystem defaultModuleName
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testCreationNew [
	self newPrototypeSystem.
	self assert: self currentSystem identicalTo: self subject.
	self assert: (self subject moduleNamed: LxxPersonsModule defaultModuleName) class name equals: #LxxPersonsModule.
	self assert: (self subject moduleNamed: LxxPrototype2Module defaultModuleName) class equals: LxxPrototype2Module.
	self assert: self subject numberOfChildModules equals: 3. 
	self assert: (self subject moduleNamed: LxxPersonsModule defaultModuleName) numberOfChildModules equals: 0.
	self assert: (self subject moduleNamed: LxxPrototype2Module defaultModuleName) numberOfChildModules equals: 1.
	self assert: (self subject moduleNamed: LxxPrototype2Submodule defaultModuleName) numberOfChildModules equals: 0.
	"self assert:system hasValidConfiguration. "
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testCreationOfNewSystem [
	self newPrototypeSystem.
	self assert: self currentSystem class identicalTo: LxxPrototypeSystem.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LxxPersons.
	self assert: self currentSystem persons collection class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	self assert: LxxPerson slotModel hasSlotDefinitions.
	self assert: self currentSystem configuration class equals: LxxPrototypeSystemConfiguration.
	self assert: self currentSystem countries collectionSize = 3 description: 'Test country codes are being initialized'
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testCreationWithPrototypeSystem [
	| domainObject |
	self newPrototypeSystem.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem identicalTo:self subject.
	self assert: (self currentSystem currentUnitOfWork addedObjects at: domainObject ifAbsent: [ nil ] ) notNil.
	self assert: domainObject slotModel className equals: 'LcsSlotModel' .
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testInstallingFirstNameSlotInPerson [
	self deny: (LxxPerson instVarNames includes: 'firstName').
	self deny: (LxxPerson respondsTo: #firstName).
	self deny: (LxxPerson respondsTo: #firstName:).
	self deny: (LxxPerson class respondsTo: #firstNameSlotDefinition).
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testNewUnitOfWorkInSystem [
	self newPrototypeSystem.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testPrototypeSystemCreation [
	| allDomainClasses |
	self newPrototypeSystem.
	self assert: self subject currentUnitOfWork hasNoChanges.
	self assert: (self subject slotDefinitionNamed: 'persons') notNil.
	self
		assert: self subject persons collection class
		identicalTo: LcsSmalltalkConfiguration identitySetClass.

	self assert: LxxPerson slotModel hasSlotDefinitions.
	self assert: self subject configuration class equals: LxxPrototypeSystemConfiguration.
	self assert: self subject hasSystemSlotModels.

	"self assertSortedCollection: self classesWithInitializeSlotModel equals: self bootstrapClasses."

	allDomainClasses := LcsBaseDomainObject withAllSubclasses asOrderedCollection.
	self subject systemSlotModel slotModels
		keysDo: [ :each | allDomainClasses remove: each ifAbsent: [  ] ].
	self
		assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotModel isNil ])
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
LxxPrototypeSystemTest >> testSystemCreation [

	self newPrototypeSystem. 

	self assert: self subject identicalTo: self currentSystem
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testSystemRemoval [

	self newPrototypeSystem.
	self assert: self subject isInActiveStatus.

	LcsApplicationEnvironment removeCurrentSystem.
	
	self assert: self subject isInSuspendedStatus.

	self assert: self systemsManager hasNoCurrentSystem.
	
	self assert: (self systemsManager systems includes: self subject) not
]

{ #category : 'tests' }
LxxPrototypeSystemTest >> testSystemRemovalWhenTwoSystemsExist [

	self newPrototypeSystem.
	self additionalNewPrototypeSystem.
	self assert: self subject isInSuspendedStatus.
	self assert: self additionalSubject isInActiveStatus.
	
	LcsApplicationEnvironment removeCurrentSystem.
	
	self assert: self subject isInSuspendedStatus.

	self assert: self systemsManager hasNoCurrentSystem.
	
	self assert: (self systemsManager systems includes: self subject).
	self assert: (self systemsManager systems includes: self additionalSubject) not.
	
	LcsApplicationEnvironment makeSystemCurrent: self subject.
	self assert: self subject isInActiveStatus.

]
