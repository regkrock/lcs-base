Class {
	#name : #LcsGlobalCollectonReferenceSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'moduleName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName: aString [ 
	moduleName := aString
]
