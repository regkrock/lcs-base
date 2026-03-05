Class {
	#name : 'LcsUuidSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsUuidSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsUuidSlot new.
	self assert: (slot isKindOf: LcsUuidSlot).
	self assert: slot slotName equals: 'uuid'.
	self assert: (slot slotTypes includes: Integer).
	self
		assert: slot initialValueBlock asString
		equals: '[ :parentDomainObject :slot | UUID new asInteger ]'.
	^slot 
]
