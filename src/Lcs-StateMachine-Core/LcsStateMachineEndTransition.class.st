Class {
	#name : #LcsStateMachineEndTransition,
	#superclass : #LcsStateMachineStateTransition,
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #actions }
LcsStateMachineEndTransition >> changeState [
	self stateMachine changeStateTo: LcsStateMachineEndState new id.
]
