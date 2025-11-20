Class {
	#name : 'LcsCommittee',
	#superclass : 'LcsOrganization',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsCommittee class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionReferenceSlot new
			addSlotType: LcsCommittees;
			slotName: 'parent';
			collectionSlotName: 'committees';
			yourself
]
