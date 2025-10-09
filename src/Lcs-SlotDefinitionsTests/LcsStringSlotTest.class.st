Class {
	#name : #LcsStringSlotTest,
	#superclass : #LcsPrototypeSystemRunningTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsStringSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'lastName'.
	self assert: subject slotName equals: 'lastName'.
	self assert: subject class == LcsStringSlot
]

{ #category : #tests }
LcsStringSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person lastName isEmpty.
]

{ #category : #tests }
LcsStringSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person lastName isEmpty.
	person lastName: 'Schmidt'.
	self assert: person isInAddingState.
	self assert: person lastName equals: 'Schmidt'.
	"This may be wrong. Should it return nil as we are in add state"
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: 'Schmidt'
]
