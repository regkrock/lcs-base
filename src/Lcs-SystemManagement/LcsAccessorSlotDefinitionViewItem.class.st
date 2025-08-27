Class {
	#name : #LcsAccessorSlotDefinitionViewItem,
	#superclass : #LcsSlotDefinitionViewItem,
	#instVars : [
		'instVarName'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #initialize }
LcsAccessorSlotDefinitionViewItem >> initialize [
	super initialize.
	self instVarName: ''
]

{ #category : #accessing }
LcsAccessorSlotDefinitionViewItem >> instVarName [
	^ instVarName
]

{ #category : #accessing }
LcsAccessorSlotDefinitionViewItem >> instVarName: anObject [
	instVarName := anObject
]
