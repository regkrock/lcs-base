Class {
	#name : #LcsPerson,
	#superclass : #LcsBasePerson,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsLegalEntitiesModule moduleName;
		collectionSlotName: 'persons';
		addSlotType: LcsPersons;
		yourself
]
