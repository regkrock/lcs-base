Class {
	#name : 'LcsPerson',
	#superclass : 'LcsBasePerson',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
			collectionSlotName: 'persons';
			addSlotType: LcsPersons;
			yourself
]
