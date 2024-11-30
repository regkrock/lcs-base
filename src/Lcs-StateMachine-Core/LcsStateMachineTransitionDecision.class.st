Class {
	#name : #LcsStateMachineTransitionDecision,
	#superclass : #LcsStateMachineStateTransition,
	#instVars : [
		'trueStateId',
		'falseStateId'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'instance creation' }
LcsStateMachineTransitionDecision class >> if: aBlockOrMessageSend trueTo: trueStateId falseTo: falseStateId [
	| inst |
	inst := self new.
	inst action: aBlockOrMessageSend.
	inst trueStateId: trueStateId.
	inst falseStateId: falseStateId.
	^inst
]

{ #category : #accessing }
LcsStateMachineTransitionDecision >> falseStateId [
	^ falseStateId
]

{ #category : #accessing }
LcsStateMachineTransitionDecision >> falseStateId: anObject [
	falseStateId := anObject
]

{ #category : #actions }
LcsStateMachineTransitionDecision >> perform [
	| evalResult |
	evalResult := super perform.
	self
		nextStateId: (evalResult
				ifTrue: [self trueStateId]
				ifFalse: [self falseStateId])
]

{ #category : #accessing }
LcsStateMachineTransitionDecision >> trueStateId [
	^ trueStateId
]

{ #category : #accessing }
LcsStateMachineTransitionDecision >> trueStateId: anObject [
	trueStateId := anObject
]
