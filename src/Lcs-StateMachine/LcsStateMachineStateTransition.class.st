Class {
	#name : 'LcsStateMachineStateTransition',
	#superclass : 'LcsStateMachineObject',
	#instVars : [
		'nextStateId',
		'guardCondition',
		'action',
		'eventType'
	],
	#category : 'Lcs-StateMachine-Core',
	#package : 'Lcs-StateMachine',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsStateMachineStateTransition class >> action: aBlockOrMessageSend to: nextStateId [
	| inst |
	inst := self nextStateId: nextStateId.
	inst action: aBlockOrMessageSend.
	^inst
]

{ #category : 'slot definitions' }
LcsStateMachineStateTransition class >> actionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsBlockSlot new
		slotName: 'action';
		yourself
]

{ #category : 'slot definitions' }
LcsStateMachineStateTransition class >> eventTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsSymbolSlot new
		slotName: 'eventType';
		inputConversionBlock: [ :parentDomainObject :anEventOrSymbol :slot | parentDomainObject asEventType: anEventOrSymbol ];
		yourself
]

{ #category : 'slot definitions' }
LcsStateMachineStateTransition class >> guardConditionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsBlockSlot new
		slotName: 'guardCondition';
		yourself
]

{ #category : 'instance creation' }
LcsStateMachineStateTransition class >> guarded: guardCondition action: aBlockOrMessageSend to: nextStateId [
	| inst |
	inst := self nextStateId: nextStateId.
	inst guardCondition: guardCondition.
	inst action: aBlockOrMessageSend.
	^inst
]

{ #category : 'instance creation' }
LcsStateMachineStateTransition class >> newId: anId with: aBlock [
	^ self new
		initializeId: anId with: aBlock;
		yourself
]

{ #category : 'actions-event' }
LcsStateMachineStateTransition class >> newWhenEvent: anEventOrSymbol transitionToStateId: nextStateId [ 
	^ self new
		initializeWhenEvent: anEventOrSymbol transitionToStateId: nextStateId;
		yourself
]

{ #category : 'instance creation' }
LcsStateMachineStateTransition class >> nextStateId: aStateSymbol [
	^self new nextStateId: aStateSymbol
]

{ #category : 'slot definitions' }
LcsStateMachineStateTransition class >> nextStateIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'nextStateId';
		yourself
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> action [
	^ action
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> action: aBlockOrMessageSend [
	action := aBlockOrMessageSend
]

{ #category : 'actions' }
LcsStateMachineStateTransition >> activate [
	self perform. 	"or send event"
	self changeState.
	
	
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> asEventType: anEventOrSymbol [
	^ anEventOrSymbol isString
		ifTrue: [ anEventOrSymbol ]
		ifFalse: [ anEventOrSymbol type ]
]

{ #category : 'actions' }
LcsStateMachineStateTransition >> changeState [
	self changeStateToStateNamed: self nextStateId.
]

{ #category : 'private' }
LcsStateMachineStateTransition >> changeStateTo: aState [

	self stateMachine changeStateTo: aState on: self currentEvent
	
]

{ #category : 'private' }
LcsStateMachineStateTransition >> changeStateToStateNamed: aStateSymbol [

	self stateMachine changeStateToStateNamed: aStateSymbol on: self currentEvent
	
]

{ #category : 'actions' }
LcsStateMachineStateTransition >> checkGuard [
	self guardCondition ifNil: [ ^ true ].
	
	^ self guardCondition cull: self context cull: self currentEvent
	
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> eventType [
	^ eventType
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> eventType: anEventOrSymbol [
	eventType := self asEventType: anEventOrSymbol
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> guardCondition [
	^ guardCondition
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> guardCondition: anObject [
	guardCondition := anObject
]

{ #category : 'instance creation' }
LcsStateMachineStateTransition >> initializeId: anId with: aBlock [
	self 
		id: anId;
		with: aBlock 
]

{ #category : 'actions-event' }
LcsStateMachineStateTransition >> initializeWhenEvent: anEventOrSymbol transitionToStateId: aNextStateId [ 
	self	
		nextStateId: aNextStateId;
		eventType: anEventOrSymbol
	
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> nextState [
	^self stateMachine stateNamed: self nextStateId.
	
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> nextStateId [
	^nextStateId
]

{ #category : 'accessing' }
LcsStateMachineStateTransition >> nextStateId: anObject [
	nextStateId := anObject
]

{ #category : 'actions' }
LcsStateMachineStateTransition >> perform [
	^ self action ifNotNil: [:act | act cull: self context cull: self currentEvent] 

]
