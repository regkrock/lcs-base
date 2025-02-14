Class {
	#name : #LcsStringSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsStringSlotTest >> testInstallation [
	subject := LxxPrototypePerson slotModel slotDefinitionNamed: 'lastName'.
	self assert: subject slotName equals: 'lastName'.
	self assert: subject class == LcsStringSlot
]

{ #category : #'as yet unclassified' }
LcsStringSlotTest >> testSlotGetter [
	| person |
	person := LxxPrototypePerson new.
	self assert: person lastName isEmpty.
]

{ #category : #'as yet unclassified' }
LcsStringSlotTest >> testSlotSetter [
	| person |
	person := LxxPrototypePerson new.
	self assert: person lastName isEmpty.
	person lastName: 'Schmidt'.
	self assert: person isAdding.
	self assert: person lastName equals: 'Schmidt'.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: ''
]
