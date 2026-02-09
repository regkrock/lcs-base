Class {
	#name : 'LcsUnknownCommitteeMember',
	#superclass : 'LcsBaseCommitteMember',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsUnknownCommitteeMember class >> titleSlotDefinition [
	<accessorSlotDefinition>
	^ super titleSlotDefinition
		initialValue: 'Open';
		yourself
]
