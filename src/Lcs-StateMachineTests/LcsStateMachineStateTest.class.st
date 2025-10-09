Class {
	#name : #LcsStateMachineStateTest,
	#superclass : #LcsPrototypeSystemRunningTestCase,
	#category : #'Lcs-StateMachineTests-Tests'
}

{ #category : #test }
LcsStateMachineStateTest >> testCreation [
	self assert: LcsStateMachineState isSlotModelPopulated.
	self subject: LcsStateMachineState new
]
