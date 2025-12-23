Class {
	#name : 'LcsStateMachineTransitionDecision',
	#superclass : 'LcsStateMachineStateTransition',
	#instVars : [
		'trueStateId',
		'falseStateId'
	],
	#category : 'Lcs-StateMachine-Core',
	#package : 'Lcs-StateMachine',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsStateMachineTransitionDecision class >> falseStateIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStateMachineEventTypeSlot new
		slotName: 'falseStateId';
		beRequired;
		yourself
]

{ #category : 'slot definitions' }
LcsStateMachineTransitionDecision class >> trueStateIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStateMachineEventTypeSlot new
		slotName: 'trueStateId';
		beRequired;
		yourself
]

{ #category : 'accessing' }
LcsStateMachineTransitionDecision >> falseStateId [
	^ falseStateId
]

{ #category : 'accessing' }
LcsStateMachineTransitionDecision >> falseStateId: anObject [
	falseStateId := anObject
]

{ #category : 'actions' }
LcsStateMachineTransitionDecision >> perform [
	| evalResult |
	evalResult := super perform.
	self
		nextStateId: (evalResult
				ifTrue: [self trueStateId]
				ifFalse: [self falseStateId])
]

{ #category : 'accessing' }
LcsStateMachineTransitionDecision >> trueStateId [
	^ trueStateId
]

{ #category : 'accessing' }
LcsStateMachineTransitionDecision >> trueStateId: anObject [
	trueStateId := anObject
]
