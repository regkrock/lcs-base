Class {
	#name : 'LcsStateMachineTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#instVars : [
		'counter'
	],
	#category : 'Lcs-StateMachineTests-Tests',
	#package : 'Lcs-StateMachineTests',
	#tag : 'Tests'
}

{ #category : 'setUp' }
LcsStateMachineTest >> domainModelTestClasses [
	^ super domainModelTestClasses
		"add: LxxCompositeStateMachine;
		add: LxxSubStateMachine;"
		yourself
]

{ #category : 'private' }
LcsStateMachineTest >> incrementCounter [
	counter := counter + 1.
	^counter asString
]

{ #category : 'private' }
LcsStateMachineTest >> initCounter [
	counter := 0
]

{ #category : 'private' }
LcsStateMachineTest >> newStateMachine [
	| stateMachine |
	stateMachine := LcsStateMachine new.
	self assert: stateMachine context isEmpty.
	self assert: stateMachine currentState isNil.
	self assert: stateMachine id equals: #''.
	self assert: stateMachine startState isNil.
	self assert: stateMachine parent isNil.
	self assert: stateMachine hasStates.
	self assert: stateMachine numberOfStates = 1.
	self assert: stateMachine hasEndState.
	self deny: stateMachine hasStartState.
	self deny: stateMachine isAtEnd.
	self deny: stateMachine isAtStart.
	^stateMachine
]

{ #category : 'running' }
LcsStateMachineTest >> setUp [
	super setUp.
	self initCounter
]

{ #category : 'testing' }
LcsStateMachineTest >> testAddingInitialState [
	| stateMachine newState |
	stateMachine := self newStateMachine.

	newState := stateMachine addStateNamed: #stateA.

	stateMachine setStartStateTo: newState.
	self assert: stateMachine startState == newState.
	self assert: stateMachine currentState == newState.
	self assert:stateMachine context isEmpty.
	self assert: stateMachine isAtStart.
	self deny: stateMachine atEnd
]

{ #category : 'testing' }
LcsStateMachineTest >> testAddingNewState [
	| stateMachine newState |
	stateMachine := self newStateMachine.

	self assert: stateMachine numberOfStates = 1.
	
	stateMachine addStateNamed: #stateA.

		self assert: stateMachine numberOfStates = 2.
	newState := stateMachine stateNamed: #stateA.
	self assert: newState id = #stateA.
	self assert: (newState isKindOf: LcsStateMachineState).
	self assert: newState subStateMachine isNil.
	self assert: newState parent identicalTo: stateMachine states.
	self assert: newState entryAction isBlock.
	self assert: newState entryAction displayString equals: '[ true ]' .
	self assert: newState exitAction isBlock.
	self assert: newState activity isBlock.
	self assert: newState currentEvent isNil
]

{ #category : 'testing' }
LcsStateMachineTest >> testAutoTransition [
	| stateMachine stateA stateB stateC |
	stateMachine := self newStateMachine.
	
	stateA := (stateMachine addStateNamed: #stateA)
		whenEvent: #toB transitionToState: #stateB.
		
	stateB := (stateMachine addStateNamed: #stateB).
	stateB activity: [self incrementCounter].
		
	stateC := (stateMachine addStateNamed: #stateC).
	stateC entryAction: [self incrementCounter].
	
	stateMachine setAutoFrom: #stateB to: #stateC.
	stateMachine setStartStateToStateNamed: #stateA.
	
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #toB.
	self assert: stateMachine currentState id equals: #stateC.
	self assert: counter = 2
]

{ #category : 'testing' }
LcsStateMachineTest >> testCompositeStateMachine [
	| stateMachine subStateMachine |
	stateMachine := LxxCompositeStateMachine new.
		
	self assert:(stateMachine currentState id = #state1).
	stateMachine handleEvent: #event12.
	
	self assert:(stateMachine currentState id = #state2).
	stateMachine handleEvent: #event12.
	subStateMachine := stateMachine currentState subStateMachine.
	
	self assert:(stateMachine currentState id = #state2).
	self assert:(stateMachine recurCurrentState id = #state2).
	
	stateMachine handleEvent: #event21.
	self assert:(stateMachine currentState id = #state1).
	self assert:(stateMachine recurCurrentState id = #state1).
	
	stateMachine handleEvent: #event12.
	self assert:(stateMachine currentState id = #state2).
	self assert:(stateMachine recurCurrentState id = #state1).
	
	self assert: (stateMachine changes asArray = #('s1->s2' 's2->s1' 's1->s2')).
	self assert: (subStateMachine changes asArray = #('ss1->ss2')).
	
]

{ #category : 'testing' }
LcsStateMachineTest >> testCreation [
	self newStateMachine
]

{ #category : 'testing' }
LcsStateMachineTest >> testDecision [
	| stateMachine steps testNum stateA stateB even odd oddEntryActionBlock |
	stateMachine := self newStateMachine.
	steps := OrderedCollection new.
	testNum := 0.
	oddEntryActionBlock := [steps add: #d].
	
	stateA := (stateMachine addStateNamed: #stateA)
				whenEvent: #toB transitionToState: #stateB.
		
	stateB := (stateMachine addStateNamed: #stateB)
				entryAction: [steps add: #b].
		
	even := (stateMachine addStateNamed: #even)
				entryAction: [steps add: #c];
				whenEvent: #toA transitionToState: #stateA;
				yourself.
	
	odd := (stateMachine addStateNamed: #odd)
				entryAction: [steps add: #d];
				whenEvent: #toA transitionToState: #stateA;
				yourself.
	self assert: odd entryAction displayString equals: oddEntryActionBlock displayString.
	
	stateMachine setDecisionFrom: #stateB if: [testNum even] trueTo: #even falseTo: #odd.
	stateMachine setStartStateToStateNamed: #stateA.
	
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #even).
	stateMachine handleEvent: #toA.
	testNum := 1.
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #odd).
	stateMachine handleEvent: #toA.
	testNum := 2.
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #even).
	self assert: steps asArray =  #(#b #c #b #d #b #c)
]

{ #category : 'testing' }
LcsStateMachineTest >> testEventWithArguments [
	| stateMachine toA toB toC stateA stateB stateC |
	stateMachine := self newStateMachine.
	
	toA := LcsStateMachineEvent newType: #toA arguments: #(#toAArg).
	toB := LcsStateMachineEvent newType: #toB arguments: #(#toBArg).
	toC := LcsStateMachineEvent newType: #toC arguments: #(#toCArg).
	
	stateA := (stateMachine addStateNamed: #stateA)
				entryAction:[:ctx :ev | ctx at: #stateAEntry put: ev];
				activity:[:ctx :ev | ctx at: #stateAActivity put: ev];
				exitAction:[:ctx :ev | ctx at: #stateAExit put: ev];
				whenEvent: toB transitionToState: #stateB;
				whenEvent: toC transitionToState: #stateC.
		
	stateB := (stateMachine addStateNamed: #stateB)
				whenEvent: toA transitionToState: #stateA.
		
	stateC := (stateMachine addStateNamed: #stateC)
				when: #toA do: [:ctx :ev | ctx at: #transCA put: ev] to: #stateA;
				endWhen: #end.
		
	stateMachine setStartStateToStateNamed: #stateA.
	self assert:(stateMachine currentState id = #stateA).
	self assert:(stateMachine context includesKey: #stateAEntry).
	self assert: ((stateMachine context at: #stateAEntry) isNil).
	self assert:(stateMachine context includesKey: #stateAActivity).
	self assert: ((stateMachine context at: #stateAActivity) isNil).
	self deny:(stateMachine context includesKey: #stateAExit).

	stateMachine handleEvent: toB.
	self assert: stateMachine currentState id equals: #stateB. 
	self assert:(stateMachine context includesKey: #stateAExit).
	self assert: (stateMachine context at: #stateAExit) arguments equals: (OrderedCollection with: #toBArg).
	
	self should: [ stateMachine handleEvent: toB ] raise: LcsStateMachineEventNotSupportedError.
	self assert:(stateMachine currentState id = #stateB).
	
	self should: [stateMachine handleEvent: #toC] raise: LcsStateMachineEventNotSupportedError.
	self assert: stateMachine currentState id equals: #stateB.
	
	stateMachine handleEvent: toA.
	self assert:stateMachine currentState id equals: #stateA.
	self assert: (stateMachine context at: #stateAEntry) arguments = (OrderedCollection with: #toAArg).
	self assert: (stateMachine context at: #stateAActivity) arguments = (OrderedCollection with:#toAArg).
	
	stateMachine handleEvent: toC.
	self assert: (stateMachine context at: #stateAExit) arguments = (OrderedCollection with:#toCArg).
	self assert: stateMachine currentState id equals: #stateC.
	self deny:(stateMachine context includesKey: #transCA).
	
	stateMachine handleEvent: toA.
	self assert: stateMachine currentState id equals: #stateA.
	self assert:(stateMachine context includesKey: #transCA).
	self assert: (stateMachine context at: #transCA) arguments = (OrderedCollection with: #toAArg).
	
	stateMachine 
		handleEvent: toC; 
		handleEvent: #end.
	
	self assert: stateMachine currentState id equals: #endState.
	self assert: ((stateMachine currentState currentEvent) isNil).
	
]

{ #category : 'testing' }
LcsStateMachineTest >> testGuardedTransition [
	| stateMachine stateA stateB stateC |
	stateMachine := self newStateMachine.
	
	stateA := (stateMachine addStateNamed: #stateA)
				when: #toB guarded: [counter < 2] to: #stateB;
				endWhen: #exit guarded: [counter >= 3].
		
	stateB := (stateMachine addStateNamed: #stateB)
				activity: [self incrementCounter];
				whenEvent: #toC transitionToState: #stateC;
				whenEvent: #toA transitionToState: #stateA.
		
	stateC := (stateMachine addStateNamed: #stateC)
				exitAction: [self incrementCounter];
				whenEvent: #toB transitionToState: #stateB.
	
	stateMachine setStartStateToStateNamed: #stateA.
	self assert: stateMachine currentState id equals: #stateA.

	stateMachine handleEvent: #exit.
	self assert: stateMachine currentState id equals: #stateA.

	stateMachine handleEvent: #toB.
	self assert: stateMachine currentState id equals: #stateB.
	self assert: counter = 1.
	
	stateMachine handleEvent: #toC.
	stateMachine handleEvent: #toB.
	stateMachine handleEvent: #toA.
	self assert: counter = 3.
	self assert: stateMachine currentState id equals: #stateA.
	
	stateMachine handleEvent: #toB.
	self assert: stateMachine currentState id equals: #stateA.
	
	stateMachine handleEvent: #exit.
	self assert: stateMachine currentState id equals: #endState.
]

{ #category : 'testing' }
LcsStateMachineTest >> testMovingFromStartStateToAnotherState [
	| stateMachine newState |
	stateMachine := self newStateMachine.

	newState := (stateMachine addStateNamed: #startState)
					whenEvent: #toStateB transitionToState: #stateB;
					yourself.
	stateMachine setStartStateTo: newState.
	self assert: stateMachine currentState id = #startState.
	
	stateMachine addStateNamed: #stateB.

	stateMachine handleEvent: #toStateB.
	
	self assert: stateMachine currentState id equals: #stateB.

]

{ #category : 'testing' }
LcsStateMachineTest >> testStateMachineContext [
	| stateMachine stateA stateB stateC |
	stateMachine := self newStateMachine.
	
	stateA := (stateMachine addStateNamed: #stateA)
		entryAction:[:ctx | ctx at: #stateAEntry put: (self incrementCounter, 'sN')];
		activity:[:ctx | ctx at: #stateAActivity put: (self incrementCounter, 'sV')];
		exitAction:[:ctx | ctx at: #stateAExit put: (self incrementCounter, 'sX')];
		whenEvent: #toB transitionToState: #stateB;
		whenEvent: #toC transitionToState: #stateC.
		
	stateB := (stateMachine addStateNamed: #stateB)
		whenEvent: #toA transitionToState: #stateA.
		
	stateC := (stateMachine addStateNamed: #stateC)
		when: #toA do: [:ctx | ctx at: #transCA put: (self incrementCounter, 'tCA')] to: #stateA;
		endWhen: #end.
		
	stateMachine setStartStateToStateNamed: #stateA.
	self assert:(stateMachine currentState id = #stateA).
	self assert:(stateMachine context includesKey: #stateAEntry).
	self assert: ((stateMachine context at: #stateAEntry) = '1sN').
	self assert:(stateMachine context includesKey: #stateAActivity).
	self assert: ((stateMachine context at: #stateAActivity) = '2sV').
	self deny:(stateMachine context includesKey: #stateAExit).

	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #stateB). 
	self assert:(stateMachine context includesKey: #stateAExit).
	self assert: ((stateMachine context at: #stateAExit) = '3sX').
	
	self should: [ stateMachine handleEvent: #toB ] raise: LcsStateMachineEventNotSupportedError.
	self assert:(stateMachine currentState id = #stateB).
	
	self should: [stateMachine handleEvent: #toC] raise: LcsStateMachineEventNotSupportedError.
	self assert:(stateMachine currentState id = #stateB).
	
	stateMachine handleEvent: #toA.
	self assert:(stateMachine currentState id = #stateA).
	self assert: ((stateMachine context at: #stateAEntry) = '4sN').
	self assert: ((stateMachine context at: #stateAActivity) = '5sV').
	
	stateMachine handleEvent: #toC.
	self assert: ((stateMachine context at: #stateAExit) = '6sX').
	self assert:(stateMachine currentState id = #stateC).
	self deny:(stateMachine context includesKey: #transCA).
	
	stateMachine handleEvent: #toA.
	self assert:(stateMachine currentState id = #stateA).
	self assert:(stateMachine context includesKey: #transCA).
	self assert: ((stateMachine context at: #transCA) = '7tCA').
	
	stateMachine handleEvent: #toC; handleEvent: #end.
	
	self assert:(stateMachine currentState id = #endState).
	self assert: ((stateMachine context at: #stateAEntry) = '8sN').
	self assert: ((stateMachine context at: #stateAActivity) = '9sV').
	self assert: ((stateMachine context at: #stateAExit) = '10sX').
]
