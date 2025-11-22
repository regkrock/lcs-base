Class {
	#name : 'LcsCommittee',
	#superclass : 'LcsInternalOrganization',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
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
