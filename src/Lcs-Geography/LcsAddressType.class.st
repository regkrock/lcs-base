Class {
	#name : 'LcsAddressType',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsAddressType class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotTypes: (OrderedCollection with: LcsAddressTypes);
			slotName: 'parent';
			collectionSlotName: 'addressTypes';
			collectionSlotModuleName: LcsGeographyModule defaultModuleName;
			yourself
]
