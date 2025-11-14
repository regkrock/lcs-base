Class {
	#name : #LcsGender,
	#superclass : #LcsSingletonValueObject,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definition' }
LcsGender class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotName: 'genders';
			collectionSlotModuleName: 'Legal Entities Module';
			addSlotType: LcsGenders;
			yourself
]
