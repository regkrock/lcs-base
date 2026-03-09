Class {
	#name : 'LcsDateRangeSlotExample',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'Examples' }
LcsDateRangeSlotExample >> newSlot [
	<gtExample>
	| slot |
	slot := LcsDateRangeSlot new.
	"self validateAccessorStyleSlot: slot."
	self assert: slot slotTypes size = 1.
	self assert: slot slotTypes first = LcsDateRange.
	self assert: slot effectiveDate = (Date newDay: 1 month: 1 year: 1970).
	self assert: slot expiryDate = (Date newDay: 31 month: 12 year: 2100).
	self assert: slot slotTypes size = 1.
	self assert: (slot slotTypes includes: LcsDateRange).
	^ slot
]
