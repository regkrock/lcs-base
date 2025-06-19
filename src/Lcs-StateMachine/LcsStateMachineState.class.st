Class {
	#name : #LcsStateMachineState,
	#superclass : #LcsStateMachineObject,
	#instVars : [
		'subStateMachine',
		'entryAction',
		'exitAction',
		'activity',
		'autoTransition',
		'stateTransitions'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'slot definitions' }
LcsStateMachineState class >> activitySlotDefinition [
	<slotDefinition>
	^ LcsBlockSlotDefinition new
		slotName: 'activity';
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> autoTransitionSlotDefinition [
	<slotDefinition>
	^ LcsBooleanSlot new
		slotName: 'autoTransition';
		initialValue: false;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> entryActionSlotDefinition [
	<slotDefinition>
	^ LcsBlockSlotDefinition new
		slotName: 'entryAction';
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> exitActionSlotDefinition [
	<slotDefinition>
	^ LcsBlockSlotDefinition new
		slotName: 'exitAction';
		yourself
]

{ #category : #'instance creation' }
LcsStateMachineState class >> named: stateName [
	^self id: stateName
]

{ #category : #'instance creation' }
LcsStateMachineState class >> named: stateName on: stateMachine [
	| state |
	state := self named: stateName.
	stateMachine addState: state.
	^state
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'states';
		addSlotType: LcsStateMachineStates;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> stateTransitionsSlotDefinition [
	<slotDefinition>
	^LcsLocalCollectionSlot new
		slotName: 'stateTransitions';
		addSlotType: LcsStateMachineTransitions; 
		addCollectionMemberType: LcsStateMachineStateTransition;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> statesTransitionsSlotDefinition [
	<slotDefinition>
	^ LcsIdentitySetSlot new
		slotName: 'stateTransitions';
		addSlotType: LcsStateMachineState;
		yourself
]

{ #category : #'slot definitions' }
LcsStateMachineState class >> subStateMachineSlotDefinition [
	<slotDefinition>
	^LcsCompositeSlot new
		slotName: 'subStateMachine';
		addSlotType: LcsStateMachine; 
		beAllowNil;
		yourself
]

{ #category : #private }
LcsStateMachineState >> activateTransitionAt: aStateTransition for: anEvent [

	aStateTransition currentEvent: anEvent.
	(aStateTransition checkGuard)
		ifTrue: [
			self currentEvent: anEvent.
			self exit.
			aStateTransition activate.
			anEvent handled: true]
]

{ #category : #accessing }
LcsStateMachineState >> activity [
	^ self slotVarNamed: 'activity'
]

{ #category : #accessing }
LcsStateMachineState >> activity: aBlockOrMessageSend [
	self slotVarNamed: 'activity' put: aBlockOrMessageSend
]

{ #category : #'actions-events-basic' }
LcsStateMachineState >> addStateTransition: aStateTransition [
	self stateTransitions add: aStateTransition.
	^ self stateMachine addStateTransition: aStateTransition
]

{ #category : #accessing }
LcsStateMachineState >> autoTransition [
	^ self slotVarNamed: 'autoTransition'
]

{ #category : #accessing }
LcsStateMachineState >> autoTransition: anObject [
	self slotVarNamed: 'autoTransition' put: anObject
]

{ #category : #'event handling' }
LcsStateMachineState >> basicHandleEvent: anEvent [
	| stateTransition |
	(stateTransition := self findStateTransitionFor: anEvent)
		ifNotNil: [ self activateTransitionAt: stateTransition for: anEvent ].
	(self shouldSubstateMachineHandle: anEvent)
		ifTrue: [ self subStateMachine handleEvent: anEvent ]
]

{ #category : #command }
LcsStateMachineState >> beAutoTransition [
	self autoTransition: true
]

{ #category : #'accessing-substates' }
LcsStateMachineState >> currentSubState [
	^self subStateMachine currentState
]

{ #category : #'state-actions' }
LcsStateMachineState >> doActivity [
	self debug: '#doActivity'.
	self activity cull: self context cull: self currentEvent.
	self isAutoTransition ifTrue: [self handleEvent: #'_ended'].

]

{ #category : #'actions-event' }
LcsStateMachineState >> endWhen: anEventOrSymbol [
	| stateTransition |
	stateTransition := LcsStateMachineEndTransition new
						eventType: anEventOrSymbol.
	self addStateTransition: stateTransition
]

{ #category : #'actions-event' }
LcsStateMachineState >> endWhen: anEventOrSymbol guarded: guardCondition [
	| stateTransition |
	stateTransition := LcsStateMachineEndTransition new
						guardCondition: guardCondition;
						eventType: anEventOrSymbol.
	^ self addStateTransition: stateTransition
]

{ #category : #'state-actions' }
LcsStateMachineState >> enter [
	self debug: '#enter'.
	self entryAction cull: self context cull: self currentEvent.
	self subStateMachine notNil
		ifTrue: [self subStateMachine start]
]

{ #category : #accessing }
LcsStateMachineState >> entryAction [
	^ self slotVarNamed: 'entryAction'
]

{ #category : #accessing }
LcsStateMachineState >> entryAction: aBlockOrMessageSend [
	self slotVarNamed: 'entryAction' put: aBlockOrMessageSend
]

{ #category : #'state-actions' }
LcsStateMachineState >> exit [
	self debug: '#exit'.
	self exitAction ifNotNil: [ :stateExitAction | stateExitAction cull: self context cull: self currentEvent].
	self subStateMachine notNil
		ifTrue: [
			self subStateMachine currentState exit.
			self subStateMachine reset]
]

{ #category : #accessing }
LcsStateMachineState >> exitAction [
	^ self slotVarNamed: 'exitAction'
]

{ #category : #accessing }
LcsStateMachineState >> exitAction: aBlockOrMessageSend [
	self slotVarNamed: 'exitAction' put: aBlockOrMessageSend
]

{ #category : #private }
LcsStateMachineState >> findStateTransitionFor: anEvent [ 
	| stateTransition |
	stateTransition := self stateTransitions
				detect: [ :each | each eventType = anEvent type ]
				ifNone: [^(LcsStateMachineEventNotSupportedError event: anEvent state: self) signal].
	^ stateTransition
	
]

{ #category : #'event handling' }
LcsStateMachineState >> handleEvent: anEventSymbolOrEvent [ 
	| event |
	event := anEventSymbolOrEvent isString 
		ifTrue: [ LcsStateMachineEvent newType: anEventSymbolOrEvent ] 
		ifFalse: [anEventSymbolOrEvent].
	^ self basicHandleEvent: event
]

{ #category : #testing }
LcsStateMachineState >> hasStateTransitions [
	^ self stateTransitions size > 0
]

{ #category : #'accessing-substates' }
LcsStateMachineState >> hasSubStates [
	^ self subStateMachine notNil and:[self subStateMachine hasStates]
	
]

{ #category : #accessing }
LcsStateMachineState >> isAutoTransition [
	^ self autoTransition == true
]

{ #category : #accessing }
LcsStateMachineState >> name [
	^self id
]

{ #category : #'actions-events-basic' }
LcsStateMachineState >> setAutoTransitionTo: aNextStateId [
	| stateTransition |
	stateTransition := 
		LcsStateMachineStateTransition new
			id: self id , aNextStateId;
			eventType: #'_ended';
			nextStateId: aNextStateId.
	self 
		beAutoTransition;
		addStateTransition: stateTransition
]

{ #category : #'actions-events-basic' }
LcsStateMachineState >> setTransitionIf: aBlockOrMessageSend trueTo: aTrueStateId falseTo: aFalseStateId [
	| stateTransition |
	stateTransition := (LcsStateMachineTransitionDecision new 
							id: self id, aTrueStateId, aFalseStateId;
							action: aBlockOrMessageSend;
							trueStateId: aTrueStateId;
							falseStateId: aFalseStateId;
							eventType: #'_ended').
	self
		beAutoTransition;
		addStateTransition: stateTransition
]

{ #category : #'event handling' }
LcsStateMachineState >> shouldSubstateMachineHandle: anEvent [
	^ anEvent handled not and: [ self subStateMachine notNil ]
]

{ #category : #'gt views' }
LcsStateMachineState >> stateMachineViewChildren [
	^ {
		LcsStateMachineViewItem newOn: self label: 'Name' item: self name.
		LcsStateMachineViewItem newOn: self label: 'Submachine' item: self subStateMachine. }
]

{ #category : #accessing }
LcsStateMachineState >> stateTransitions [
	^ self slotVarNamed: 'stateTransitions'
]

{ #category : #accessing }
LcsStateMachineState >> stateTransitions: anObject [
	self slotVarNamed: 'stateTransitions' put: anObject
]

{ #category : #accessing }
LcsStateMachineState >> subStateMachine [
	^subStateMachine
]

{ #category : #accessing }
LcsStateMachineState >> subStateMachine: aStateMachine [
	subStateMachine := aStateMachine
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol do: transitionAction to: nextStateId [
	| stateTransition |
	stateTransition := LcsStateMachineStateTransition new
						nextStateId: nextStateId;
						eventType: anEventOrSymbol;
						action: transitionAction.
	self addStateTransition: stateTransition
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol guarded: guardCondition do: transitionAction to: nextStateId [
	| stateTransition |
	stateTransition := LcsStateMachineStateTransition new
						nextStateId: nextStateId;
						eventType: anEventOrSymbol;
						guardCondition: guardCondition;
						action: transitionAction.
	self addStateTransition: stateTransition
]

{ #category : #'actions-event' }
LcsStateMachineState >> when: anEventOrSymbol guarded: guardCondition to: nextStateId [
	| stateTransition |
	stateTransition := LcsStateMachineStateTransition new
						nextStateId: nextStateId;
						eventType: anEventOrSymbol;
						guardCondition: guardCondition.
	self addStateTransition: stateTransition
]

{ #category : #'actions-event' }
LcsStateMachineState >> whenEvent: anEventOrSymbol transitionToState: nextStateId [
	| stateTransition |
	stateTransition := LcsStateMachineStateTransition new
						nextStateId: nextStateId;
						eventType: anEventOrSymbol.
	^ self addStateTransition: stateTransition
]
