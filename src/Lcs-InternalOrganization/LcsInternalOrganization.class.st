Class {
	#name : 'LcsInternalOrganization',
	#superclass : 'LcsOrganization',
	#instVars : [
		'committees'
	],
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsInternalOrganization class >> committeesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		addSlotType: LcsCommittees;
		addCollectionMemberType: LcsCommittee;
		slotName: 'committees';
		yourself
]

{ #category : 'accessing' }
LcsInternalOrganization >> committees [
	^ self slotVarNamed: 'committees' 
]

{ #category : 'accessing' }
LcsInternalOrganization >> committees: anObject [
	self slotVarNamed: 'committees' put: anObject 
]

{ #category : 'organization model' }
LcsInternalOrganization >> internalOrganization [
	^ self
]
