Class {
	#name : #LcsSlotDefinitionTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsSlotDefinitionTest class >> subjectClass [
	^ LcsSlotDefinition
]

{ #category : #tests }
LcsSlotDefinitionTest >> testCreation [

	self createNewSubject.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotName isNil.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date)
]
