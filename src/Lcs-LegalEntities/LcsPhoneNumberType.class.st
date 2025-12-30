Class {
	#name : 'LcsPhoneNumberType',
	#superclass : 'LcsValueObject',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsPhoneNumberType class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumberTypes);
		slotName: 'parent';
		collectionSlotName: 'phoneNumberTypes';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		yourself
]
