Class {
	#name : 'LcsSmalltalkObjectSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSmalltalkObjectSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsSmalltalkObjectSlot new.
	self assert: (slot isKindOf: LcsSmalltalkObjectSlot).
	self assert: slot slotName isNil.
	self assert: slot slotTypes isEmpty.
	self assert: slot initialValue isNil.
	^ slot
]

{ #category : 'examples' }
LcsSmalltalkObjectSlotExamples >> newSlotWithOrderedCollectionType [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot addSlotType: OrderedCollection.
	self assert: (slot slotTypes includes: OrderedCollection).
	self assert: (slot initialValue isKindOf: OrderedCollection).
	^ slot
]
