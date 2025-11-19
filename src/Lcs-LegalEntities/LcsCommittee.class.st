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
			slotTypes: (OrderedCollection with: LcsCommittees);
			slotName: 'parent';
			collectionSlotName: 'committees';
			yourself
]
