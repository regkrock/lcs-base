Class {
	#name : 'LcsObjectVersionSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsObjectVersionSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsObjectVersionSlot new.
	self assert: (slot isKindOf: LcsObjectVersionSlot).
	self assert: slot slotName equals: 'version'.
	self assert: (slot slotTypes includes: SmallInteger).
	self deny: (slot slotTypes includes: UndefinedObject).
	self assert: slot initialValueBlock asString equals: '[ :parentDomainObject :slot | 0 ]'.
	self assert: slot initialValue equals: 0.
	^ slot
]
