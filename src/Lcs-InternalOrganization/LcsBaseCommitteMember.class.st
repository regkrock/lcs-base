Class {
	#name : 'LcsBaseCommitteMember',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'title',
		'member'
	],
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBaseCommitteMember class >> memberSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfLocalCollectionSlot new
		slotName: 'member';
		addSlotType: LcsMember;
		initialValueBlock: [ :parentDomainObject :slot | slot currentSystem organization members defaultInstance ];
		collectionSlotName: 'members';
		yourself
]

{ #category : 'slot definitions' }
LcsBaseCommitteMember class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionReferenceSlot new
		addSlotType: LcsCommitteeMembers;
		slotName: 'parent';
		collectionSlotName: 'committeeMembers';
		yourself
]

{ #category : 'slot definitions' }
LcsBaseCommitteMember class >> titleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'title';
		required: true;
		yourself
]

{ #category : 'organization model' }
LcsBaseCommitteMember >> internalOrganization [
	^ self parent internalOrganization
]

{ #category : 'accessing' }
LcsBaseCommitteMember >> member [
	^ self slotVarNamed: 'member'
]

{ #category : 'accessing' }
LcsBaseCommitteMember >> member: anObject [
	self slotVarNamed: 'member' put: anObject
]

{ #category : 'accessing' }
LcsBaseCommitteMember >> title [
	^ self slotVarNamed: 'title'
]

{ #category : 'accessing' }
LcsBaseCommitteMember >> title: anObject [
	self slotVarNamed: 'title' put: anObject
]
