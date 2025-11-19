Class {
	#name : 'LcsAccessorSlotDefinitionViewItem',
	#superclass : 'LcsSlotDefinitionViewItem',
	#instVars : [
		'instVarName'
	],
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'private' }
LcsAccessorSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	^ false
]

{ #category : 'initialize' }
LcsAccessorSlotDefinitionViewItem >> initialize [
	super initialize.
	self instVarName: ''
]

{ #category : 'accessing' }
LcsAccessorSlotDefinitionViewItem >> instVarName [
	^ instVarName
]

{ #category : 'accessing' }
LcsAccessorSlotDefinitionViewItem >> instVarName: anObject [
	instVarName := anObject
]
