Class {
	#name : 'LcsDomainObjectSlotChange',
	#superclass : 'LcsSupportDomainObject',
	#instVars : [
		'slotName',
		'newValue'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDomainObjectSlotChange class >> newValueSlotDefinition [
	<accessorSlotDefinition>
	^ LcsValueHistorySlot new
		slotName: 'newValue';
		yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectSlotChange class >> slotNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'history' }
LcsDomainObjectSlotChange >> addSlotChangesOf: aSlotName to: slotChangeHistory [
	slotChangeHistory add: (
		Array 
			with: aSlotName
			with: self newValue printString
			with: self created printString)
]

{ #category : 'history' }
LcsDomainObjectSlotChange >> created [
	^ self parent created
]

{ #category : 'accessing' }
LcsDomainObjectSlotChange >> newValue [
	^ self slotVarNamed: 'newValue'
]

{ #category : 'accessing' }
LcsDomainObjectSlotChange >> newValue: anObject [
	self slotVarNamed: 'newValue' put: anObject
]

{ #category : 'accessing' }
LcsDomainObjectSlotChange >> slotName [
	^ self slotVarNamed: 'slotName'
]

{ #category : 'accessing' }
LcsDomainObjectSlotChange >> slotName: anObject [
	self slotVarNamed: 'slotName' put: anObject
]
