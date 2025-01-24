Class {
	#name : #LcsStateMachineStateTest,
	#superclass : #LcsPrototypeSystemTest,
	#category : #'Lcs-StateMachineTests-Tests'
}

{ #category : #subject }
LcsStateMachineStateTest class >> subjectClass [
	^LcsStateMachineState
]

{ #category : #subject }
LcsStateMachineStateTest >> createNewSubject [
	self assert: self subjectClass isSlotModelPopulated.
	super createNewSubject
]

{ #category : #test }
LcsStateMachineStateTest >> testCreation [
	self createNewSubject
]
