Class {
	#name : 'LcsCommittee',
	#superclass : 'LcsInternalOrganization',
	#instVars : [
		'committeeMembers'
	],
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCommittee class >> committeeMembersSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		addSlotType: LcsCommitteeMembers;
		addCollectionMemberType: LcsCommitteeMember;
		slotName: 'committeeMembers';
		yourself
]

{ #category : 'slot definitions' }
LcsCommittee class >> committeeNameSlotDefinition [
	<facadeSlotDefinition>
	^ LcsDelegatorSlot new
			slotName: 'committeeName';
			addSlotType: String;
			targetSlotPath: #(#organizationName);
			yourself
]

{ #category : 'slot definitions' }
LcsCommittee class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionReferenceSlot new
		addSlotType: LcsCommittees;
		slotName: 'parent';
		collectionSlotName: 'committees';
		yourself
]

{ #category : 'accessing' }
LcsCommittee >> committeeMembers [
	^ self slotVarNamed: 'committeeMembers'
]

{ #category : 'accessing' }
LcsCommittee >> committeeMembers: anObject [
	self slotVarNamed: 'committeeMembers' put: anObject
]

{ #category : 'accessing' }
LcsCommittee >> committeeName [
	^ self slotVarNamed: 'committeeName'
]

{ #category : 'accessing' }
LcsCommittee >> committeeName: anObject [
	self slotVarNamed: 'committeeName' put: anObject
]

{ #category : 'organization model' }
LcsCommittee >> internalOrganization [
	^ self parent internalOrganization
]
