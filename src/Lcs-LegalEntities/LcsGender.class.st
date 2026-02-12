Class {
	#name : 'LcsGender',
	#superclass : 'LcsSingletonValueObject',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definition' }
LcsGender class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'genders';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		addSlotType: LcsGenders;
		yourself
]
