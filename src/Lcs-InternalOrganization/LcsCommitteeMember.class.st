Class {
	#name : 'LcsCommitteeMember',
	#superclass : 'LcsBaseCommitteMember',
	#instVars : [
		'title',
		'member'
	],
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCommitteeMember class >> memberSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfLocalCollectionSlot new
			slotName: 'member';
			addSlotType: LcsMember;
			initialValueBlock: [ :parentDomainObject :slot | parentDomainObject internalOrganization
	members defaultInstance ];
			collectionSlotName: 'members';
			yourself
]

{ #category : 'slot definitions' }
LcsCommitteeMember class >> titleSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
			slotName: 'title';
			required: true;
			yourself
]

{ #category : 'accessing' }
LcsCommitteeMember >> member [
	^ self slotVarNamed: 'member'
]

{ #category : 'accessing' }
LcsCommitteeMember >> member: anObject [
	self slotVarNamed: 'member' put: anObject
]

{ #category : 'accessing' }
LcsCommitteeMember >> title [
	^ self slotVarNamed: 'title'
]

{ #category : 'accessing' }
LcsCommitteeMember >> title: anObject [
	self slotVarNamed: 'title' put: anObject
]
