Class {
	#name : #LcsStateMachineEndTransition,
	#superclass : #LcsStateMachineStateTransition,
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #actions }
LcsStateMachineEndTransition >> changeState [
	self stateMachine changeStateToStateNamed: LcsStateMachineEndState new id.
]
