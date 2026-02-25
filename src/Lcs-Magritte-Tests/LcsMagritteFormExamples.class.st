Class {
	#name : 'LcsMagritteFormExamples',
	#superclass : 'LcsObjectExamples',
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#category : 'Lcs-Magritte-Tests-Examples',
	#package : 'Lcs-Magritte-Tests',
	#tag : 'Examples'
}

{ #category : 'debugging' }
LcsMagritteFormExamples >> simulateClickOnAcceptButtonAction [
	"This is to be used for debugging purposes"
	self subjectScripterMemento commit.
	self subjectScripter model buildJobSteps
]
