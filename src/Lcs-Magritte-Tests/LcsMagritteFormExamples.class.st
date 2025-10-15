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

{ #category : #debugging }
LcsMagritteFormExamples >> simulateClickOnAcceptButtonAction [
	"This is to be used for debugging purposes"
	self subjectScripterMemento commit.
	self subjectScripter model buildJobSteps
]

{ #category : #accessing }
LcsMagritteFormExamples >> subject [
	^ subject
]

{ #category : #accessing }
LcsMagritteFormExamples >> subject: anObject [
	subject := anObject
]
