Class {
	#name : 'LcsStringSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStringSlotExamples >> lstNameStringSlot [
	<gtExample>
	| slot |
	slot := self newSlot
			slotName: 'lastName';
			yourself.
	^ slot
]

{ #category : 'examples' }
LcsStringSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsStringSlot new.
	self assert: slot slotTypes size = 1.
	self assert: (slot slotTypes includes: String).
	self assert: slot initialValue = ''.
	^ slot
]
