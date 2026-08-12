Class {
	#name : 'LcsTableCollectionFilter',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'filterBlock'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableCollectionFilter class >> filterBlockSlotDefinition [
	<accessorSlotDefinition>
	^ LcsBlockSlot new
		slotName: 'filterBlock';
		yourself
]

{ #category : 'accessing' }
LcsTableCollectionFilter >> filterBlock [
	^ self slotVarNamed: 'filterBlock'
]

{ #category : 'accessing' }
LcsTableCollectionFilter >> filterBlock: anObject [
	self slotVarNamed: 'filterBlock' put: anObject
]
