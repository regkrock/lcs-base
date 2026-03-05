Class {
	#name : 'LcsLocalCollectionReferenceSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsLocalCollectionReferenceSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsLocalCollectionReferenceSlotBuilder new.
	self assert: builder class slotClass equals: LcsLocalCollectionReferenceSlot.
	^ builder
]
