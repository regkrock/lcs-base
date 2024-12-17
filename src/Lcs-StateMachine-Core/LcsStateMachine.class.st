Class {
	#name : #LcsStateMachine,
	#superclass : #LcsDomainObject,
	#instVars : [
		'currentState',
		'stateDict',
		'transDict',
		'listeners',
		'startState',
		'context',
		'owner',
		'id'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #private }
LcsStateMachine >> addListener: aStatechart [ 
	self listeners add: aStatechart
]

{ #category : #adding }
LcsStateMachine >> addState: aState [
	^self stateAt: aState id put: aState
]

{ #category : #actions }
LcsStateMachine >> addStateNamed: stateName [
	^ self addState: (LcsStateMachineState named: stateName)
]

{ #category : #adding }
LcsStateMachine >> addTransition: aTransition [
	^self transAt: aTransition id put: aTransition
]

{ #category : #testing }
LcsStateMachine >> atEnd [
	^self currentState isKindOf: LcsStateMachineEndState
]

{ #category : #private }
LcsStateMachine >> basicHandleEvent: anEvent ifFailed: aBlock [
	self listeners	do: [:each | each handleEvent: anEvent copy].
		
	self currentState handleEvent: anEvent.
	anEvent handled ifFalse: [
		aBlock cull: self
	].
	
]

{ #category : #'changing state' }
LcsStateMachine >> changeStateTo: aStateSymbol [
	self changeStateTo: aStateSymbol on: nil
]

{ #category : #'changing state' }
LcsStateMachine >> changeStateTo: aStateSymbol on: anEvent [
	| state |
	state := self stateAt: aStateSymbol.
	state currentEvent: anEvent.
	self updateCurrentState: state.
]

{ #category : #accessing }
LcsStateMachine >> context [
	context isNil ifTrue: [context := Dictionary new].
	^context
]

{ #category : #accessing }
LcsStateMachine >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LcsStateMachine >> currentState [
	^currentState
]

{ #category : #accessing }
LcsStateMachine >> currentState: aState [
	currentState := aState
]

{ #category : #debugging }
LcsStateMachine >> debug: anObject [ 
	LcsDebugLogger default debug: anObject
]

{ #category : #'gt views' }
LcsStateMachine >> gtStateMachineViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'State Machine';
		priority: 10;
		expandUpTo: 3;
		items: [ self stateMachineViewChildren ];
		children: [ :viewItem | viewItem children ];
		column: 'Option'
			text: [ :viewItem | viewItem label ]
			width: 200;
		column: 'Value' text: [ :viewItem | viewItem itemDisplay displayString ] width: 300;
		column: '' stencil: [ :viewItem | viewItem actionButton] width: 70;
		column: '' stencil: [ :viewItem | viewItem action2Button] width: 70;
		send: #item;
		actionUpdateButton;
		yourself
]

{ #category : #'event handling' }
LcsStateMachine >> handleEvent: anEventSymbolOrEvent [ 
	^self handleEvent: anEventSymbolOrEvent ifFailed: []
]

{ #category : #'event handling' }
LcsStateMachine >> handleEvent: anEventSymbolOrEvent ifFailed: aBlock [
	| evt |
	evt := anEventSymbolOrEvent isString ifTrue: [(LcsStateMachineEvent type: anEventSymbolOrEvent)] ifFalse: [anEventSymbolOrEvent].
	^self basicHandleEvent: evt ifFailed: aBlock
]

{ #category : #testing }
LcsStateMachine >> hasStates [
	^self stateDict size > 0
]

{ #category : #testing }
LcsStateMachine >> hasTransitions [
	^self transDict size > 0
]

{ #category : #accessing }
LcsStateMachine >> id [
	^ id
]

{ #category : #accessing }
LcsStateMachine >> id: anObject [
	id := anObject
]

{ #category : #'initialize-release' }
LcsStateMachine >> initialize [
	self addState: LcsStateMachineEndState new.
	
]

{ #category : #accessing }
LcsStateMachine >> listeners [
	listeners isNil ifTrue:[ listeners := OrderedCollection new].
	^listeners
]

{ #category : #accessing }
LcsStateMachine >> listeners: anOrderedCollection [
	listeners := anOrderedCollection
]

{ #category : #accessing }
LcsStateMachine >> owner [
	^ owner
]

{ #category : #accessing }
LcsStateMachine >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
LcsStateMachine >> recurCurrentState [
	| state |
	state := self currentState.
	state isNil
		ifTrue: [^ self].
	[state hasSubStates]
		whileTrue: [state := state currentSubState].
	^ state
]

{ #category : #actions }
LcsStateMachine >> reset [
	self currentState: self startState
]

{ #category : #actions }
LcsStateMachine >> setAutoFrom: stateId to: nextStateId [
	|  state trans transId |
	state := self stateAt: stateId.
	state isAuto: true.
	transId := stateId, nextStateId.
	state when: #'_ended' fire: transId.
	trans := (LcsStateMachineStateTransition nextStateId: nextStateId).
	self transAt: transId put: trans
]

{ #category : #actions }
LcsStateMachine >> setDecisionFrom: stateId if: aBlockOrMessageSend trueTo: trueStateId falseTo: falseStateId [
	|  state trans transId |
	state := self stateAt: stateId.
	state isAuto: true.
	transId := stateId, trueStateId, falseStateId.
	state when: #'_ended' fire: transId.
	trans := (LcsStateMachineTransitionDecision if: aBlockOrMessageSend trueTo: trueStateId falseTo: falseStateId).
	self transAt: transId put: trans
]

{ #category : #actions }
LcsStateMachine >> setStartStateTo: aStateSymbol [
	self startState: (self stateAt: aStateSymbol).
	self changeStateTo: aStateSymbol
]

{ #category : #actions }
LcsStateMachine >> start [
	self reset.
	self currentState enter.
	self currentState doActivity
]

{ #category : #accessing }
LcsStateMachine >> startState [
	^startState
]

{ #category : #accessing }
LcsStateMachine >> startState: aState [
	startState := aState
]

{ #category : #'actions-basic' }
LcsStateMachine >> stateAt: aStateName [
	^self stateDict at: aStateName ifAbsent:[LcsStateMachineNoSuchStateError signal: aStateName asString]
]

{ #category : #'actions-basic' }
LcsStateMachine >> stateAt: aStateName ifAbsent: aBlock [
	^self stateDict at: aStateName ifAbsent: aBlock
]

{ #category : #'actions-basic' }
LcsStateMachine >> stateAt: aStateName put: aState [
	aState stateMachine: self.
	^self stateDict at: aStateName put: aState
]

{ #category : #accessing }
LcsStateMachine >> stateDict [
	stateDict isNil ifTrue:[stateDict := IdentityDictionary new].
	^stateDict
]

{ #category : #accessing }
LcsStateMachine >> stateDict: aState [
	stateDict := aState
]

{ #category : #'gt views' }
LcsStateMachine >> stateMachineViewChildren [
	^ {
		LcsStateMachineViewItem newOn: self label: 'Owner' item: self owner.
		LcsStateMachineViewItem newOn: self label: 'Current State' item: self currentState displaySelector: #id.
		LcsStateMachineViewItem newOn: self label: 'States' item: self states.
		"LcsStateMachineViewItem newOn: self label: 'Units Of Work' item: self unitsOfWorkManager."}
]

{ #category : #'as yet unclassified' }
LcsStateMachine >> states [
	^ self stateDict values
]

{ #category : #'actions-basic' }
LcsStateMachine >> transAt: aTransitionId [
	^self transAt: aTransitionId ifAbsent: [LcsStateMachineNoSuchTransitionError signal: aTransitionId]
]

{ #category : #'actions-basic' }
LcsStateMachine >> transAt: aTransitionId ifAbsent: aBlock [
	^self transDict at: aTransitionId ifAbsent: aBlock
]

{ #category : #'actions-basic' }
LcsStateMachine >> transAt: aTransitionId put: aTransition [
	aTransition stateMachine: self.
	^self transDict at: aTransitionId put: aTransition
]

{ #category : #accessing }
LcsStateMachine >> transDict [
	transDict isNil ifTrue:[transDict := IdentityDictionary new].
	^transDict
]

{ #category : #accessing }
LcsStateMachine >> transDict: aState [
	transDict := aState
]

{ #category : #private }
LcsStateMachine >> updateCurrentState: aState [
	self currentState: aState.
	aState enter.
	aState doActivity.
	
]
