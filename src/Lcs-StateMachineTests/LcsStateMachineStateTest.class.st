Class {
	#name : 'LcsStateMachineStateTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#category : 'Lcs-StateMachineTests-Tests',
	#package : 'Lcs-StateMachineTests',
	#tag : 'Tests'
}

{ #category : 'test' }
LcsStateMachineStateTest >> testCreation [
	self assert: LcsStateMachineState isSlotModelPopulated.
	self subject: LcsStateMachineState new
]
