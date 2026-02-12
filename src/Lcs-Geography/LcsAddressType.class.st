Class {
	#name : 'LcsAddressType',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsAddressType class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsAddressTypes);
		slotName: 'parent';
		collectionSlotName: 'addressTypes';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		yourself
]

{ #category : 'testing' }
LcsAddressType >> isUnknown [
	^ self code = 'unknown'
]
