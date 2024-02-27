Class {
	#name : #LcsGlobalCollectonReferenceSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'moduleName'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName: aString [ 
	moduleName := aString
]
