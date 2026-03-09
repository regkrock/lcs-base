Class {
	#name : 'LcsStateMachineStateExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-StateMachineTests-Examples',
	#package : 'Lcs-StateMachineTests',
	#tag : 'Examples'
}

{ #category : 'test' }
LcsStateMachineStateExamples >> newStateMachineState [
	self ensureCurrentSystemIsPrototypeSystem.
	self assert: LcsStateMachineState isSlotModelPopulated.
	self subject: LcsStateMachineState new
]
