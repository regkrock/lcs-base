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
	^ LcsDeprecatedSlot new
		slotName: 'tableDefinitions';
		yourself
]
