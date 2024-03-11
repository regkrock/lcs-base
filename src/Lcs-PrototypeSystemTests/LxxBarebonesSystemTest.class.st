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
	
	self assert: LxxPerson slotDefinitions hasElements
]
