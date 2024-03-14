Class {
	#name : #LxxBarebonesSystemTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LxxBarebonesSystemTest >> testCreation [
	LxxBarebonesSystem newSystem.
	self assert: self currentUnitOfWork hasNoChanges.
	self assert: (self currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: self currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPerson slotDefinitions hasElements.
	self assert: self currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #accessing }
LxxBarebonesSystemTest >> testCreationWithBareBonesSystem [
	| domainObject |
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem == LcsSystemManager currentSystem.
	self assert: (self currentSystem currentUnitOfWork addRecordFor: domainObject) domainObject == domainObject.
	self assert: (domainObject slotDefintions isKindOf: LcsSlotDefinitions) .
]
