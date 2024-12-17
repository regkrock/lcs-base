Class {
	#name : #LcsStateMachineState,
	#superclass : #LcsStateMachineObject,
	#instVars : [
		'transDict',
		'subStateMachine',
		'entryAction',
		'exitAction',
		'activity',
		'isAuto'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'instance creation' }
LcsStateMachineState class >> named: stateName [
	^self id: stateName
]

{ #category : #'instance creation' }
LcsStateMachineState class >> named: stateName on: stateMachine [
	| inst |
	inst := self named: stateName.
	stateMachine addState: inst.
	^inst
]

{ #category : #private }
LcsStateMachineState >> activateTransitionAt: transId for: anEvent [
	| trans | 
			trans := self stateMachine
						transAt: transId
						ifAbsent: [^LcsStateMachineNoSuchTransitionError signal: transId printString].
			trans currentEvent: anEvent.
			(trans checkGuard)
				ifTrue: [self currentEvent: anEvent.
					self exit.
					trans activate.
					anEvent handled: true]
]

{ #category : #accessing }
LcsStateMachineState >> activity [
	^ activity
]

{ #category : #accessing }
LcsStateMachineState >> activity: aBlockOrMessageSend [
	activity := aBlockOrMessageSend
]

{ #category : #'event handling' }
LcsStateMachineState >> basicHandleEvent: anEvent [ 
	| transId |
	transId := self findTransId: anEvent.
	transId isNil ifFalse: [self activateTransitionAt: transId for: anEvent].
	(anEvent handled not and: [self subStateMachine notNil]) ifTrue: [self subStateMachine handleEvent: anEvent]
]

{ #category : #'accessing-substates' }
LcsStateMachineState >> currentSubState [
	^self subStateMachine currentState
]

{ #category : #'state-actions' }
LcsStateMachineState >> doActivity [
	self debug: '#doActivity'.
	self activity ifNotNil: [:act | act cull: self context cull: self currentEvent].
	self isAuto ifTrue: [self handleEvent: #'_ended'].

]

{ #category : #'actions-event' }
LcsStateMachineState >> endWhen: anEventOrSymbol [
	self when: anEventOrSymbol doTransition: (LcsStateMachineEndTransition new) 
]

{ #category : #'actions-event' }
LcsStateMachineState >> endWhen: anEventOrSymbol guarded: guardCondition [
	| trans |
	trans := LcsStateMachineEndTransition new.
	trans guardCondition: guardCondition.
	self when: anEventOrSymbol doTransition: trans 
]

{ #category : #'state-actions' }
LcsStateMachineState >> enter [
	self debug: '#enter'.
	self entryAction ifNotNil: [:act | act cull: self context cull: self currentEvent].
	self subStateMachine notNil
		ifTrue: [self subStateMachine start]
]

{ #category : #accessing }
LcsStateMachineState >> entryAction [
	^ entryAction
]

{ #category : #accessing }
LcsStateMachineState >> entryAction: aBlockOrMessageSend [
	entryAction := aBlockOrMessageSend
]

{ #category : #'state-actions' }
LcsStateMachineState >> exit [
	self debug: '#exit'.
	self exitAction ifNotNil: [:act | act cull: self context cull: self currentEvent].
	self subStateMachine notNil
		ifTrue: [self subStateMachine currentState exit.
				self subStateMachine reset]
]

{ #category : #accessing }
LcsStateMachineState >> exitAction [
	^ exitAction
]

{ #category : #accessing }
LcsStateMachineState >> exitAction: aBlockOrMessageSend [
	exitAction := aBlockOrMessageSend
]

{ #category : #private }
LcsStateMachineState >> findTransId: anEvent [ 
	| transId |
	transId := self transDict
				at: anEvent type
				ifAbsent: [^(LcsStateMachineEventNotSupportedError event: anEvent state: self) signal].
	^transId
	
]

{ #category : #'event handling' }
LcsStateMachineState >> handleEvent: anEventSymbolOrEvent [ 
	| evt |
	evt := anEventSymbolOrEvent isString ifTrue: [(LcsStateMachineEvent type: anEventSymbolOrEvent)] ifFalse: [anEventSymbolOrEvent].
	^self basicHandleEvent: evt
]

{ #category : #'accessing-substates' }
LcsStateMachineState >> hasSubStates [
	^self subStateMachine notNil and:[self subStateMachine hasStates]
	
]

{ #category : #accessing }
LcsStateMachineState >> isAuto [
	^ isAuto ifNil: [isAuto := false]
]

{ #category : #accessing }
LcsStateMachineState >> isAuto: anObject [
	isAuto := anObject
]

{ #category : #accessing }
LcsStateMachineState >> name [
	^self id
]

{ #category : #'gt views' }
LcsStateMachineState >> stateMachineViewChildren [
	^ {
		LcsStateMachineViewItem newOn: self label: 'Name' item: self name.
		LcsStateMachineViewItem newOn: self label: 'Submachine' item: self subStateMachine. }
]

{ #category : #accessing }
LcsStateMachineState >> subStateMachine [
	^subStateMachine
]

{ #category : #accessing }
LcsStateMachineState >> subStateMachine: aStateMachine [
	subStateMachine := aStateMachine
]

{ #category : #accessing }
LcsStateMachineState >> transDict [
	transDict isNil ifTrue: [ transDict := IdentityDictionary new].
	^transDict
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol do: transitionAction to: nextStateId [
	self when: anEventOrSymbol doTransition: (LcsStateMachineStateTransition action: transitionAction to: nextStateId) 
]

{ #category : #'actions-events-basic' }
LcsStateMachineState >> when: anEventOrSymbol doTransition: aTransition [ 
	| eventType |
	eventType := anEventOrSymbol isString ifTrue: [anEventOrSymbol] ifFalse: [anEventOrSymbol type].
	self when: eventType fire: aTransition id.
	self stateMachine addTransition: aTransition.
]

{ #category : #'actions-events-basic' }
LcsStateMachineState >> when: anEventTypeSymbol fire: aTransitionSymbol [
	^self transDict at: anEventTypeSymbol put: aTransitionSymbol
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol guarded: guardCondition do: transitionAction to: nextStateId [
	self when: anEventOrSymbol doTransition: (LcsStateMachineStateTransition guarded: guardCondition action: transitionAction to: nextStateId) 
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol guarded: guardCondition to: nextStateId [
	| trans |
	trans := LcsStateMachineStateTransition nextStateId: nextStateId.
	trans guardCondition: guardCondition.
	self when: anEventOrSymbol doTransition: (trans) 
]

{ #category : #'actions-event' }
LcsStateMachineState >> whenEvent: anEventOrSymbol transitionToState: nextStateId [
	self when: anEventOrSymbol doTransition: (LcsStateMachineStateTransition nextStateId: nextStateId) 
]
