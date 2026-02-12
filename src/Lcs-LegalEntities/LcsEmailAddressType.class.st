Class {
	#name : 'LcsEmailAddressType',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsEmailAddressType class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsEmailAddressTypes);
		slotName: 'parent';
		collectionSlotName: 'emailAddressTypes';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		yourself
]
