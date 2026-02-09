Class {
	#name : 'LcsSteeringCommittee',
	#superclass : 'LcsCommittee',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSteeringCommittee class >> commodoreSlotDefinition [
	<collectionItemSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'commodore';
			addSlotType: LcsCommitteeMember;
			targetSlotPath: #(#title) asOrderedCollection;
			collectionSlotName: 'committeeMembers';
			targetItem: 'Commodore';
			yourself
]

{ #category : 'slot definitions' }
LcsSteeringCommittee class >> secretarySlotDefinition [
	<collectionItemSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'secretary';
			addSlotType: LcsCommitteeMember;
			required: true;
			targetSlotPath: #(#title) asOrderedCollection;
			collectionSlotName: 'committeeMembers';
			targetItem: 'Secretary';
			yourself
]

{ #category : 'slot definitions' }
LcsSteeringCommittee class >> treasurerSlotDefinition [
	<collectionItemSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'treasurer';
			addSlotType: LcsCommitteeMember;
			targetSlotPath: #(#title) asOrderedCollection;
			collectionSlotName: 'committeeMembers';
			targetItem: 'Treasurer';
			yourself
]

{ #category : 'slot definitions' }
LcsSteeringCommittee class >> viceCommodoreSlotDefinition [
	<collectionItemSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'viceCommodore';
			addSlotType: LcsCommitteeMember;
			targetSlotPath: #(#title) asOrderedCollection;
			collectionSlotName: 'committeeMembers';
			targetItem: 'Vice-Commodore';
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

{ #category : 'accessing' }
LcsSteeringCommittee >> secretary [
	^ self slotVarNamed: 'secretary'
]

{ #category : 'accessing' }
LcsSteeringCommittee >> secretary: anObject [
	self slotVarNamed: 'secretary' put: anObject
]

{ #category : 'accessing' }
LcsSteeringCommittee >> treasurer [
	^ self slotVarNamed: 'treasurer'
]

{ #category : 'accessing' }
LcsSteeringCommittee >> treasurer: anObject [
	self slotVarNamed: 'treasurer' put: anObject
]

{ #category : 'accessing' }
LcsSteeringCommittee >> viceCommodore [
	^ self slotVarNamed: 'viceCommodore'
]

{ #category : 'accessing' }
LcsSteeringCommittee >> viceCommodore: anObject [
	self slotVarNamed: 'viceCommodore' put: anObject
]
