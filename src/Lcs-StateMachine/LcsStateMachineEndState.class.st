Class {
	#name : #LcsStateMachineEndState,
	#superclass : #LcsStateMachineState,
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'state-actions' }
LcsStateMachineEndState >> doActivity [
	"NEVER DO ANYTHING"	
]

{ #category : #'state-actions' }
LcsStateMachineEndState >> exit [
	"NEVER DO ANYTHING"	
]

{ #category : #accessing }
LcsStateMachineEndState >> id [
	^#endState
]
