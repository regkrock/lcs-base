Class {
	#name : 'LcsDateSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsDateSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsDateSlot new.
	self assert: slot slotName isNil.
	self assert: slot initialValue equals: Date today.
	self assert: slot validationConditions isEmpty.
	^ slot
]

{ #category : 'tests' }
LcsDateSlotExamples >> slotWithChangedInitialValueBlock [
	<gtExample>
	| initialValue slot |
	slot := self newSlot.
	initialValue := slot initialValue.
	self assert: slot initialValue equals: Date today.

	slot initialValueBlock: [ Date today subtractDays: 10 ].
	self assert: slot initialValue equals: (Date today subtractDays: 10).
	^ slot
]
