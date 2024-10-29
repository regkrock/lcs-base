Class {
	#name : #LcsMenuDefinition,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'cssClasses'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #asking }
LcsMenuDefinition >> componentName [
	self subclassResponsibility
]

{ #category : #accessing }
LcsMenuDefinition >> cssClasses [
	^ cssClasses
]

{ #category : #'as yet unclassified' }
LcsMenuDefinition >> cssClasses: aString [
	cssClasses := aString
]

{ #category : #'as yet unclassified' }
LcsMenuDefinition >> initialize [
	super initialize.
	self cssClasses: ''
]

{ #category : #accessing }
LcsMenuDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsMenuDefinition >> parent: anObject [
	parent := anObject
]
