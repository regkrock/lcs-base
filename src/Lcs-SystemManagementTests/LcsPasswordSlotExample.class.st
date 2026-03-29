Class {
	#name : 'LcsPasswordSlotExample',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPasswordSlotExample >> newSlot [
	<gtExample>
	| slot |
	slot := LcsPasswordSlot new.
	self assert: slot slotName equals: 'password'.
	self assert: (slot slotTypes includes: String)
]
