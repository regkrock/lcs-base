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
		initialValueBlock: [:collection | collection ];
		yourself
]

{ #category : 'execution' }
LcsTableCollectionFilter >> evaluateOn: aCollection [
	^ self filterBlock value: aCollection
]

{ #category : 'accessing' }
LcsTableCollectionFilter >> filterBlock [
	^ self slotVarNamed: 'filterBlock'
]

{ #category : 'accessing' }
LcsTableCollectionFilter >> filterBlock: anObject [
	self slotVarNamed: 'filterBlock' put: anObject
]
