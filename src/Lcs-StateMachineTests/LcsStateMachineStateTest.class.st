Class {
	#name : #LcsStateMachineStateTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-StateMachineTests-Tests'
}

{ #category : #test }
LcsStateMachineStateTest >> testCreation [
	self assert: LcsStateMachineState isSlotModelPopulated.
	self subject: LcsStateMachineState new
]
