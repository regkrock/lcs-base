Class {
	#name : #LcsTitle,
	#superclass : #LcsValueObject,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definition' }
LcsTitle class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotName: 'titles';
			collectionSlotModuleName: 'Legal Entities Module';
			addSlotType: LcsTitles;
			yourself
]
