Class {
	#name : #LcsPhoneNumberType,
	#superclass : #LcsValueObject,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPhoneNumberType class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumberTypes);
		slotName: 'parent';
		collectionSlotName: 'phoneNumberTypes';
		collectionSlotModuleName: 'Legal Entities Module';
		yourself
]
