Class {
	#name : 'LcsTableColumnDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'slotName',
		'label'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> labelSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'label';
		required: true;
		yourself
]

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> slotNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		required: true;
		yourself
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> label [
	^ self slotVarNamed: 'label'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> label: anObject [
	self slotVarNamed: 'label' put: anObject
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName [
	^ self slotVarNamed: 'slotName'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName: anObject [
	self slotVarNamed: 'slotName' put: anObject
]
