Class {
	#name : 'LcsJustification',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-SystemSupport-Core',
	#package : 'Lcs-SystemSupport',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsJustification class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		addSlotType: LcsJustifications;
		slotName: 'parent';
		collectionSlotName: 'justifications';
		collectionSlotModuleName: LcsSystemSupportModule defaultModuleName;
		yourself
]
