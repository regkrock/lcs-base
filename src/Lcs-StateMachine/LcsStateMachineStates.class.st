Class {
	#name : #LcsStateMachineStates,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #testing }
LcsStateMachineStates class >> isBaseSystemClass [
]

{ #category : #'as yet unclassified' }
LcsStateMachineStates >> stateMachine [
	^ self parent
]
