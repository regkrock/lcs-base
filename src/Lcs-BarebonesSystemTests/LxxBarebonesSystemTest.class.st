Class {
	#name : #LxxBarebonesSystemTest,
	#superclass : #LcsDomainTestCase,
	#instVars : [
		'system1',
		'system2'
	],
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #running }
LxxBarebonesSystemTest >> tearDown [
	system1 ifNotNil: [ 
		system1 remove.
		system1 := nil ].
	system2 ifNotNil: [ 
		system2 remove.
		system2 := nil ].
	super tearDown

]

{ #category : #tests }
LxxBarebonesSystemTest >> testAddDomainObject [
	| domainObject |
	system1 := LxxBarebonesSystem new.
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
LxxBarebonesSystemTest >> testBarebonesCreation [
	| domainClassesNotUsedInTheSystem allDomainClasses |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	system1 := LxxBarebonesSystem new.
	self assert: system1 currentUnitOfWork hasNoChanges.
	self assert: (system1 slotDefinitionNamed: 'persons' ) notNil.
	self assert: system1 persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: system1 configuration class name equals: #LxxBarebonesSystemConfiguration.
	self assert: system1 hasSlotDefinitions .
	self assert: system1 slotModel slotDefinitions size = LcsSystemManager currentSystem domainClasses size.
	allDomainClasses := LcsDomainObject withAllSubclasses asOrderedCollection.
	system1 slotModel slotDefinitions keys do: [:each | allDomainClasses remove: each ifAbsent: [ ] ].
	self assert: (allDomainClasses allSatisfy: [ :eachClass | eachClass slotDefinitions isNil ])
]

{ #category : #tests }
LxxBarebonesSystemTest >> testChangedSlotInDomainObject [
	| domainObject |
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	domainObject := LxxBarebonesPerson new dateOfBirth: Date today.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: domainObject dateOfBirth equals: Date today.
	self assert: ((self currentSystem persons) includes: domainObject).
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

	domainObject dateOfBirth: Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects size equals: 1.
	self assert: (self currentSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: self currentSystem currentUnitOfWork changedObjects any domainObject identicalTo: domainObject.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth = Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreation [
	| numberOfSystems |
	numberOfSystems := self systemManager numberOfSystems.
	system1 := LxxBarebonesSystem new. 
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1 
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationOfNewSystem [
	system1 := LxxBarebonesSystem new.
	self assert: self currentSystem class identicalTo: LxxBarebonesSystem.
	self assert: (self currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: self currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationWithBareBonesSystem [
	| domainObject |
	system1 := LxxBarebonesSystem new.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem == system1.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject == domainObject.
	self assert: (domainObject slotDefinitions isKindOf: LcsSlotDefinitions) .
]

{ #category : #tests }
LxxBarebonesSystemTest >> testNewUnitOfWorkInSystem [
	system1 := LxxBarebonesSystem new.
	self assert: self currentSystem currentUnitOfWork system identicalTo: self  currentSystem
]

{ #category : #tests }
LxxBarebonesSystemTest >> testSystemRemoval [
	| numberOfSystems numberOfUnitsOfWork |
	
	numberOfSystems := self systemManager numberOfSystems.
	numberOfUnitsOfWork := self unitsOfWorkManager numberOfUnitsOfWork.
	system1 := LxxBarebonesSystem new.
	system2 := LxxBarebonesSystem new.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 2.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 2. 
	self assert: (self unitsOfWorkManager unitOfWorkFor: system1) system identicalTo: system1.
	self assert: (self unitsOfWorkManager unitOfWorkFor: system2) system identicalTo: system2.

	self assert: LcsApplicationEnvironment currentSystem identicalTo: system2.
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: self systemManager numberOfSystems equals: numberOfSystems + 1.
	self assert: self unitsOfWorkManager numberOfUnitsOfWork equals: numberOfUnitsOfWork + 1.
	self assert: self systemManager hasNoCurrentSystem.
	self assert: (self systemManager systems includes: system1).
	self assert: self systemManager currentUnitOfWork isNil.
	
	LcsApplicationEnvironment makeSystemCurrent: system1.
	self assert: self systemManager currentSystem identicalTo: system1.
	self assert: self systemManager currentUnitOfWork system identicalTo: system1.


]
