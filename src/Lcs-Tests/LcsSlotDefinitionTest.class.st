Class {
	#name : #LcsSlotDefinitionTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #accessing }
LcsSlotDefinitionTest >> testCreation [
	| slotDefinition |
	slotDefinition := LcsSlotDefinition new.
	self assert: slotDefinition slotTypes isEmpty.
	self assert: slotDefinition slotName isNil.
	slotDefinition slotName: #test.
	self assert: slotDefinition slotName = #test.
	slotDefinition addSlotType: Date.
	self assert: (slotDefinition slotTypes includes: Date)
]
