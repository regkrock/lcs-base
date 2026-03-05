Class {
	#name : 'LcsLocalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsLocalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsLocalCollectionSlotBuilder new.
	self assert: builder class slotClass equals: LcsLocalCollectionSlot.
	^ builder
]
