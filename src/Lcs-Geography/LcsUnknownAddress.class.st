Class {
	#name : 'LcsUnknownAddress',
	#superclass : 'LcsAddress',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsUnknownAddress class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsParentSlot new
]

{ #category : 'testing' }
LcsUnknownAddress >> isUnknown [
	^ true
]
