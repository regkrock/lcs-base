Class {
	#name : 'LcsBaseCommitteMember',
	#superclass : 'LcsDomainObject',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBaseCommitteMember class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionReferenceSlot new
		addSlotType: LcsCommitteeMembers;
		slotName: 'parent';
		collectionSlotName: 'committeeMembers';
		yourself
]

{ #category : 'organization model' }
LcsBaseCommitteMember >> internalOrganization [
	^ self parent internalOrganization
]
