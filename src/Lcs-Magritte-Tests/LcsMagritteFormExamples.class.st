Class {
	#name : #LcsMagritteFormExamples,
	#superclass : #LcsObjectExamples,
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#instVars : [
		'subject'
	],
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #accessing }
LcsMagritteFormExamples >> subject [
	^ subject
]

{ #category : #accessing }
LcsMagritteFormExamples >> subject: anObject [
	subject := anObject
]
