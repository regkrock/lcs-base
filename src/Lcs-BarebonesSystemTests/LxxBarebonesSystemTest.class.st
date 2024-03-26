Class {
	#name : #LxxBarebonesSystemTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LxxBarebonesSystemTest >> testAddDomainObject [
	| domainObject |
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
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
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	LxxBarebonesSystem newSystem.
	self assert: LcsUnitOfWorkManager currentUnitOfWork hasNoChanges.
	self assert: (LcsSystemManager currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: LcsSystemManager currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: LcsSystemManager currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
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
	LxxBarebonesSystem newSystem.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: (self currentSystem slotDefinitionNamed: 'persons') notNil.
	self assert: self currentSystem persons class identicalTo: LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationOfNewSystem [
	LxxBarebonesSystem newSystem.
	self assert: LcsSystemManager currentSystem class identicalTo: LxxBarebonesSystem.
	self assert: (LcsSystemManager currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: LcsSystemManager currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxBarebonesPerson slotDefinitions hasElements.
	self assert: LcsSystemManager currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #tests }
LxxBarebonesSystemTest >> testCreationWithBareBonesSystem [
	| domainObject |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem == LcsSystemManager currentSystem.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject == domainObject.
	self assert: (domainObject slotDefintions isKindOf: LcsSlotDefinitions) .
]

{ #category : #tests }
LxxBarebonesSystemTest >> testNewUnitOfWorkInSystem [
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	self assert: (self currentSystem currentUnitOfWork system == self  currentSystem)
]
