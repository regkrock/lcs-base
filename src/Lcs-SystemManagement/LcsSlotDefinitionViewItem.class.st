Class {
	#name : #LcsSlotDefinitionViewItem,
	#superclass : #LcsObject,
	#instVars : [
		'instVarName'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #'as yet unclassified' }
LcsSlotDefinitionViewItem >> initialize [
	super initialize.
	self instVarName: ''
]

{ #category : #initialize }
LcsSlotDefinitionViewItem >> initializeOn: aSlotDefinition [ 
]

{ #category : #accessing }
LcsSlotDefinitionViewItem >> instVarName [
	^ instVarName
]

{ #category : #accessing }
LcsSlotDefinitionViewItem >> instVarName: anObject [
	instVarName := anObject
]

{ #category : #testing }
LcsSlotDefinitionViewItem >> isAccessorSlot [
	^ false
]

{ #category : #testing }
LcsSlotDefinitionViewItem >> isVirtualSlot [
	^ false
]
