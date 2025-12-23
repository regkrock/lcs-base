Class {
	#name : 'LcsGender',
	#superclass : 'LcsSingletonValueObject',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definition' }
LcsGender class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'genders';
		collectionSlotModuleName: 'Legal Entities Module';
		addSlotType: LcsGenders;
		yourself
]
