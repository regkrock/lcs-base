Class {
	#name : 'LcsSingletonValueObjectsGlobalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSingletonValueObjectsGlobalCollectionSlotBuilder new.
	self assert: builder class slotClass equals: LcsSingletonValueObjectsGlobalCollectionSlot.
	^ builder
]
