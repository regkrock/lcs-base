Class {
	#name : 'LcsIntegerSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsIntegerSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsIntegerSlot new.
	self
		assert: slot initialValueBlock printString
		equals: '[ :parentDomainObject :slot | 0 ]'.
	self assert: slot stepValue equals: 1.
	^ slot
]

{ #category : 'examples' }
LcsIntegerSlotExamples >> triggerInvalidSlotTypeError [
	<gtExample>
	| slot |
	slot := self weightNumberSlot.
	self should: [ slot slotVarPut: 0.02s in: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot slotVarPut: 'abc' in: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot slotVarPut: 1/2 in: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot slotVarPut: 3.14 in: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	^ slot
]

{ #category : 'examples' }
LcsIntegerSlotExamples >> weightNumberSlot [
	<gtExample>
	| slot |
	slot := self newSlot
				slotName: 'weight';
				yourself.
	^ slot
]

{ #category : 'examples' }
LcsIntegerSlotExamples >> weightNumberSlotInitialValueChangedTo100 [
	<gtExample>
	| slot |
	slot := self weightNumberSlot.
	slot initialValue: 100.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | 100 ]'.
	self assert: slot initialValue equals: 100.
	^ slot initialValue
]
