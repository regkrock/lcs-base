Class {
	#name : 'LcsStateMachineStates',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-StateMachine-Core',
	#package : 'Lcs-StateMachine',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsStateMachineStates class >> isBaseSystemClass [
]

{ #category : 'as yet unclassified' }
LcsStateMachineStates >> stateMachine [
	^ self parent
]
