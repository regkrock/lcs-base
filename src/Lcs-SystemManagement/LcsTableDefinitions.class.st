Class {
	#name : 'LcsTableDefinitions',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableDefinitions class >> tableDefinitionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsNullSlot new
		slotName: 'tableDefinitions';
		yourself
]
