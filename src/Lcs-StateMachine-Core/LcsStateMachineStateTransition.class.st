Class {
	#name : #LcsStateMachineStateTransition,
	#superclass : #LcsStateMachineObject,
	#instVars : [
		'nextStateId',
		'guardCondition',
		'action'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'instance creation' }
LcsStateMachineStateTransition class >> action: aBlockOrMessageSend to: nextStateId [
	| inst |
	inst := self nextStateId: nextStateId.
	inst action: aBlockOrMessageSend.
	^inst
]

{ #category : #'instance creation' }
LcsStateMachineStateTransition class >> guarded: guardCondition action: aBlockOrMessageSend to: nextStateId [
	| inst |
	inst := self nextStateId: nextStateId.
	inst guardCondition: guardCondition.
	inst action: aBlockOrMessageSend.
	^inst
]

{ #category : #'instance creation' }
LcsStateMachineStateTransition class >> nextStateId: aStateSymbol [
	^self new nextStateId: aStateSymbol
]

{ #category : #accessing }
LcsStateMachineStateTransition >> action [
	^ action
]

{ #category : #accessing }
LcsStateMachineStateTransition >> action: aBlockOrMessageSend [
	action := aBlockOrMessageSend
]

{ #category : #actions }
LcsStateMachineStateTransition >> activate [
	self perform. 	"or send event"
	self changeState.
	
	
]

{ #category : #actions }
LcsStateMachineStateTransition >> changeState [
	self changeStateTo: self nextStateId.
]

{ #category : #private }
LcsStateMachineStateTransition >> changeStateTo: aStateSymbol [

	self stateMachine changeStateTo: aStateSymbol on: self currentEvent
	
]

{ #category : #actions }
LcsStateMachineStateTransition >> checkGuard [
	self guardCondition ifNil: [ ^true ].
	
	^self guardCondition cull: self context	cull: self currentEvent
	
]

{ #category : #accessing }
LcsStateMachineStateTransition >> guardCondition [
	^ guardCondition
]

{ #category : #accessing }
LcsStateMachineStateTransition >> guardCondition: anObject [
	guardCondition := anObject
]

{ #category : #accessing }
LcsStateMachineStateTransition >> nextState [
	^self stateMachine stateAt: self nextStateId.
	
]

{ #category : #accessing }
LcsStateMachineStateTransition >> nextStateId [
	^nextStateId
]

{ #category : #accessing }
LcsStateMachineStateTransition >> nextStateId: anObject [
	nextStateId := anObject
]

{ #category : #actions }
LcsStateMachineStateTransition >> perform [
	^ self action ifNotNil: [:act | act cull: self context cull: self currentEvent] 

]
