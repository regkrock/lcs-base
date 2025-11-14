Class {
	#name : #LcsUnknownPerson,
	#superclass : #LcsBasePerson,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsUnknownPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
			collectionSlotName: 'persons';
			addSlotType: LcsPersons;
			yourself
]
