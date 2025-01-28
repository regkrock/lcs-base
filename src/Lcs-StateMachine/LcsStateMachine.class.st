Class {
	#name : #LcsStateMachine,
	#superclass : #LcsDomainObject,
	#instVars : [
		'currentState',
		'states',
		'stateTransitions',
		'listeners',
		'startState',
		'context',
		'id'
	],
	#category : #'Lcs-StateMachine'
}

{ #category : #'slot definitions' }
LcsStateMachine class >> contextSlotDefinition [
	<slotDefinition>
	^ LcsAggregateSlot new
		slotName: 'context';
		addSlotType: Object;
		allowNil;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> currentStateSlotDefinition [
	<slotDefinition>
	^ LcsStateMachineStateSlot new
		slotName: 'currentState';
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> idSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'id';
		addSlotType: String; 
		allowNil;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> listenersSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'listeners';
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> startStateSlotDefinition [
	<slotDefinition>
	^ LcsAggregateSlot new
		slotName: 'startState';
		addSlotType: LcsStateMachineState;
		allowNil;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> stateTransitionsSlotDefinition [
	<slotDefinition>
	^ LcsSecondaryCollectionSlot new
		slotName: 'stateTransitions';
		addSlotType: LcsStateMachineTransitions; 
		addCollectionMemberType: LcsStateMachineStateTransition;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachine class >> statesSlotDefinition [
	<slotDefinition>
	^LcsLocalCollectionSlot new
		slotName: 'states';
		addSlotType: LcsStateMachineStates; 
		addCollectionMemberType: LcsStateMachineState;
		yourself
]

{ #category : #private }
LcsStateMachine >> addListener: aStatechart [ 
	self listeners add: aStatechart
]

{ #category : #adding }
LcsStateMachine >> addState: aState [
	"aState parent: self."
	^ self states add: aState
]

{ #category : #actions }
LcsStateMachine >> addStateNamed: stateName [
	^ self addState: (LcsStateMachineState named: stateName)
]

{ #category : #'actions-basic' }
LcsStateMachine >> addStateTransition: aStateTransition [
	aStateTransition stateMachine: self.
	^ self stateTransitions add: aStateTransition
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
LcsStateMachine >> changeStateTo: state [
	self changeStateTo: state on: nil
]

{ #category : #'changing state' }
LcsStateMachine >> changeStateTo: state on: anEvent [
	state currentEvent: anEvent.
	self updateCurrentState: state
]

{ #category : #'changing state' }
LcsStateMachine >> changeStateToStateNamed: aStateSymbol [
	self changeStateToStateNamed: aStateSymbol on: nil
]

{ #category : #'changing state' }
LcsStateMachine >> changeStateToStateNamed: aStateSymbol on: anEvent [
	| state |
	state := self stateNamed: aStateSymbol.
	self changeStateTo: state on: anEvent
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
	evt := anEventSymbolOrEvent isString ifTrue: [(LcsStateMachineEvent newType: anEventSymbolOrEvent)] ifFalse: [anEventSymbolOrEvent].
	^self basicHandleEvent: evt ifFailed: aBlock
]

{ #category : #testing }
LcsStateMachine >> hasEndState [
	self states detect: [ :each | each isKindOf: LcsStateMachineEndState ] ifNone: [ ^false ].
	^ true
]

{ #category : #testing }
LcsStateMachine >> hasStartState [
	^ self startState notNil
]

{ #category : #testing }
LcsStateMachine >> hasStateTransitions [
	^self stateTransitions size > 0
]

{ #category : #testing }
LcsStateMachine >> hasStates [
	^self states size > 0
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
	super initialize.
	self addState: LcsStateMachineEndState new.
	
]

{ #category : #testing }
LcsStateMachine >> isAtEnd [
	^self currentState isKindOf: LcsStateMachineEndState
]

{ #category : #testing }
LcsStateMachine >> isAtStart [
	^ self startState notNil and: [
		self startState == self currentState ]
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

{ #category : #testing }
LcsStateMachine >> numberOfStates [
	^self states size
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
LcsStateMachine >> setAutoFrom: aStateId to: aNextStateId [
	(self stateNamed: aStateId) setAutoTransitionTo: aNextStateId
]

{ #category : #actions }
LcsStateMachine >> setDecisionFrom: stateId if: aBlockOrMessageSend trueTo: aTrueStateId falseTo: aFalseStateId [
	(self stateNamed: stateId) setTransitionIf: aBlockOrMessageSend trueTo: aTrueStateId falseTo: aFalseStateId
]

{ #category : #actions }
LcsStateMachine >> setStartState: aState [
	self startState: aState.
	self changeStateTo: aState
]

{ #category : #actions }
LcsStateMachine >> setStartStateTo: aState [
	self setStartState: aState
]

{ #category : #actions }
LcsStateMachine >> setStartStateToStateNamed: aStateSymbol [
	self setStartState: (self stateNamed: aStateSymbol)
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

{ #category : #'gt views' }
LcsStateMachine >> stateMachineViewChildren [
	^ {
		LcsStateMachineViewItem newOn: self label: 'Parent' item: self parent.
		LcsStateMachineViewItem newOn: self label: 'Current State' item: self currentState displaySelector: #id.
		LcsStateMachineViewItem newOn: self label: 'States' item: self states.
		"LcsStateMachineViewItem newOn: self label: 'Units Of Work' item: self unitsOfWorkManager."}
]

{ #category : #'actions-basic' }
LcsStateMachine >> stateNamed: aStateName [
	^self states detect: [ :each | each name = aStateName ] ifNone:[LcsStateMachineNoSuchStateError signal: aStateName asString]
]

{ #category : #'actions-basic' }
LcsStateMachine >> stateTransitionNamed: aTransitionId ifNone: aBlock [
	^self stateTransitions detect: [ :each | each id = aTransitionId ] ifNone: aBlock
]

{ #category : #accessing }
LcsStateMachine >> stateTransitions [
	^ self slotVarNamed: 'stateTransitions'
]

{ #category : #accessing }
LcsStateMachine >> stateTransitions: anObject [
	self slotVarNamed: 'stateTransitions' put: anObject
]

{ #category : #accessing }
LcsStateMachine >> states [
	^ self slotVarNamed: 'states'
]

{ #category : #accessing }
LcsStateMachine >> states: aCollection [
	^ self slotVarNamed: 'states' put: aCollection
]

{ #category : #'actions-basic' }
LcsStateMachine >> transAt: aTransitionId [
	^self stateTransitionNamed: aTransitionId ifNone: [LcsStateMachineNoSuchTransitionError signal: aTransitionId]
]

{ #category : #'actions-basic' }
LcsStateMachine >> transAt: aTransitionId put: aStateTransition [
	aStateTransition stateMachine: self.
	^self stateTransitions add: aStateTransition
]

{ #category : #private }
LcsStateMachine >> updateCurrentState: aState [
	self currentState: aState.
	aState enter.
	aState doActivity.
	
]
