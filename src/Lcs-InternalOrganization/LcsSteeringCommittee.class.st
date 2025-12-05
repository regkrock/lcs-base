Class {
	#name : 'LcsSteeringCommittee',
	#superclass : 'LcsCommittee',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSteeringCommittee class >> commodoreSlotDefinition [
	<facadeSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'commodore';
			addSlotType: LcsCommitteeMember;
			targetSlotPath: #(#title) asOrderedCollection;
			collectionSlotName: 'committeeMembers';
			targetItem: 'Commodore';
			yourself
]

{ #category : 'accessing' }
LcsSteeringCommittee >> commodore [
	^ self slotVarNamed: 'commodore'
]

{ #category : 'accessing' }
LcsSteeringCommittee >> commodore: anObject [
	self slotVarNamed: 'commodore' put: anObject
]
