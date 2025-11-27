Class {
	#name : 'LcsCommittee',
	#superclass : 'LcsInternalOrganization',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

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
	<slotDefinition>
	^ LcsLocalCollectionReferenceSlot new
			addSlotType: LcsCommittees;
			slotName: 'parent';
			collectionSlotName: 'committees';
			yourself 
]

{ #category : 'accessing' }
LcsCommittee >> committeeName [
	^ self slotVarNamed: 'committeeName'
]

{ #category : 'accessing' }
LcsCommittee >> committeeName: anObject [
	self slotVarNamed: 'committeeName' put: anObject
]
