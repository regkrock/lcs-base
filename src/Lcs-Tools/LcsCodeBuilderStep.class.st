Class {
	#name : #LcsCodeBuilderStep,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeBuilderStep >> builderJob [
	^ self parent builderJob
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent [
	^ parent
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsCodeBuilderStep >> populateSlotModel [
	"Subclasses should implement as needed"
]

{ #category : #install }
LcsCodeBuilderStep >> updateSlotModel [
	self subclassResponsibility
]

{ #category : #install }
LcsCodeBuilderStep >> verifyCodeInstallation [
	self subclassResponsibility
]

{ #category : #install }
LcsCodeBuilderStep >> verifySlotModelUpdates [
	self subclassResponsibility
]
