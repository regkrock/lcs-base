Class {
	#name : 'LcsNumberSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsNumberSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsNumberSlot new.
	self
		assert: slot initialValueBlock printString
		equals: '[ :parentDomainObject :slot | 0 ]'.
	self assert: slot stepValue isNil.
	^ slot
]

{ #category : 'examples' }
LcsNumberSlotExamples >> weightNumberSlot [
	<gtExample>
	| slot |
	slot := self newSlot
				slotName: 'weight';
				stepValue: 0.01;
				yourself.
	self assert: slot stepValue equals: 0.01.
	self assert: slot stepValue asString equals: '0.01'.
	^ slot
]

{ #category : 'examples' }
LcsNumberSlotExamples >> weightNumberSlotInitialValueChangedTo100 [
	<gtExample>
	| slot |
	slot := self weightNumberSlot.
	slot initialValue: 100.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | 100 ]'.
	self assert: slot initialValue equals: 100.
	^ slot initialValue
]
