Class {
	#name : 'LcsNullSlot',
	#superclass : 'LcsDomainSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsNullSlot >> defaultPragmaSelector [
	^'accessorSlotDefinition'
]

{ #category : 'initialize' }
LcsNullSlot >> initializeSlotValueIn: aDomainObject [
	"do nothing for the null sllot"
]

{ #category : 'slot model' }
LcsNullSlot >> slotVarNamed: anObject in: aDomainObject [
	LcsSlotUpdateNotAllowedError signal:  'This is a read only slot'
]
