Class {
	#name : #LcsBooleanSlotTest,
	#superclass : #LcsPrototypeSystemTest,
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #setUp }
LcsBooleanSlotTest >> domainModelTestClasses [
	^ super domainModelTestClasses
		add: LxxExampleDomain;
		add: LxxExampleComponent;
		yourself
]

{ #category : #tests }
LcsBooleanSlotTest >> testInitializeOfBooleanSlotInNewDomainObject [
	| object |
	object := LxxExampleDomain new.
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: object).
	self assert: object boolean equals: true.
	self assert: (object getPersistedValueOf: 'boolean') = true.
	"self currentSystem currentUnitOfWork halt applyChanges."
]
