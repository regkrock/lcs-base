Class {
	#name : #LcsMenuDefinition,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #asking }
LcsMenuDefinition >> componentName [
	self subclassResponsibility
]

{ #category : #accessing }
LcsMenuDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsMenuDefinition >> parent: anObject [
	parent := anObject
]
