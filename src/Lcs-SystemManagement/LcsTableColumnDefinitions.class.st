Class {
	#name : 'LcsTableColumnDefinitions',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableColumnDefinitions class >> tableDefinitionsSlotDefinition [
	<accessorSlotDefinition>
	"^ LcsDeprecatedSlot new
		slotName: 'tableDefinitions';
		yourself"
	^ super tableDefinitionsSlotDefinition
]
