Class {
	#name : #LcsEmailAddressType,
	#superclass : #LcsValueObject,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsEmailAddressType class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotTypes: (OrderedCollection with: LcsEmailAddressTypes);
			slotName: 'parent';
			collectionSlotName: 'emailAddressTypes';
			collectionSlotModuleName: 'Legal Entities Module';
			yourself
]
