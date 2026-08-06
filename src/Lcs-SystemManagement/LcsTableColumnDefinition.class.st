Class {
	#name : 'LcsTableColumnDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'slotName'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> slotNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		required: true;
		yourself
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName [
	^ self slotVarNamed: 'slotName'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName: anObject [
	self slotVarNamed: 'slotName' put: anObject
]
