Class {
	#name : #LcsStateMachineTest,
	#superclass : #LcsPrototypeSystemTest,
	#instVars : [
		'counter'
	],
	#category : #'Lcs-StateMachine-Tests'
}

{ #category : #private }
LcsStateMachineTest >> incrementCounter [
	counter := counter + 1.
	^counter asString
]

{ #category : #private }
LcsStateMachineTest >> initCounter [
	counter := 0
]

{ #category : #testing }
LcsStateMachineTest >> testAutoTransition [
	| stateMachine stateA stateB stateC |
	stateMachine := LcsStateMachine new.
	self initCounter.
	
	stateA := (stateMachine addStateNamed: #stateA)
		whenEvent: #toB transitionToState: #stateB.
		
	stateB := (stateMachine addStateNamed: #stateB).
	stateB activity: [self incrementCounter].
		
	stateC := (stateMachine addStateNamed: #stateC).
	stateC entryAction: [self incrementCounter].
	
	stateMachine setAutoFrom: #stateB to: #stateC.
	stateMachine setStartStateTo: #stateA.
	
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #stateC).
	self assert: counter = 2
]

{ #category : #testing }
LcsStateMachineTest >> testCompositeStateMachine [
	| stateMachine subStateMachine |
	stateMachine := LcsTestCompositeStateMachine new.
	self initCounter.
		
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

{ #category : #testing }
LcsStateMachineTest >> testDecision [
	| stateMachine steps testNum stateA stateB even odd |
	stateMachine := LcsStateMachine new.
	steps := OrderedCollection new.
	testNum := 0.
	
	stateA := (stateMachine addStateNamed: #stateA)
		whenEvent: #toB transitionToState: #stateB.
		
	stateB := (stateMachine addStateNamed: #stateB).
	stateB entryAction: [steps add: #b].
		
	even := (stateMachine addStateNamed: #even).
	even entryAction: [steps add: #c].
	even whenEvent: #toA transitionToState: #stateA.
	
	odd := (stateMachine addStateNamed: #odd).
	odd entryAction: [steps add: #d].
	odd whenEvent: #toA transitionToState: #stateA.
	
	stateMachine setDecisionFrom: #stateB if: [testNum even] trueTo: #even falseTo: #odd.
	stateMachine setStartStateTo: #stateA.
	
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

{ #category : #testing }
LcsStateMachineTest >> testEventWithArguments [
	| stateMachine toA toB toC stateA stateB stateC |
	stateMachine := LcsStateMachine new.
	self initCounter.
	
	toA := LcsStateMachineEvent type: #toA arguments: #(#toAArg).
	toB := LcsStateMachineEvent type: #toB arguments: #(#toBArg).
	toC := LcsStateMachineEvent type: #toC arguments: #(#toCArg).
	
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
		
	stateMachine setStartStateTo: #stateA.
	self assert:(stateMachine currentState id = #stateA).
	self assert:(stateMachine context includesKey: #stateAEntry).
	self assert: ((stateMachine context at: #stateAEntry) isNil).
	self assert:(stateMachine context includesKey: #stateAActivity).
	self assert: ((stateMachine context at: #stateAActivity) isNil).
	self deny:(stateMachine context includesKey: #stateAExit).

	stateMachine handleEvent: toB.
	self assert:(stateMachine currentState id = #stateB). 
	self assert:(stateMachine context includesKey: #stateAExit).
	self assert: ((stateMachine context at: #stateAExit) arguments = #(#toBArg)).
	
	self should: [ stateMachine handleEvent: toB ] raise: LcsStateMachineEventNotSupportedError.
	self assert:(stateMachine currentState id = #stateB).
	
	self should: [stateMachine handleEvent: #toC] raise: LcsStateMachineEventNotSupportedError.
	self assert:(stateMachine currentState id = #stateB).
	
	stateMachine handleEvent: toA.
	self assert:(stateMachine currentState id = #stateA).
	self assert: ((stateMachine context at: #stateAEntry) arguments = #(#toAArg)).
	self assert: ((stateMachine context at: #stateAActivity) arguments = #(#toAArg)).
	
	stateMachine handleEvent: toC.
	self assert: ((stateMachine context at: #stateAExit) arguments = #(#toCArg)).
	self assert:(stateMachine currentState id = #stateC).
	self deny:(stateMachine context includesKey: #transCA).
	
	stateMachine handleEvent: toA.
	self assert:(stateMachine currentState id = #stateA).
	self assert:(stateMachine context includesKey: #transCA).
	self assert: ((stateMachine context at: #transCA) arguments = #(#toAArg)).
	
	stateMachine handleEvent: toC; handleEvent: #end.
	
	self assert:(stateMachine currentState id = #endState).
	self assert: ((stateMachine currentState currentEvent) isNil).
	
]

{ #category : #testing }
LcsStateMachineTest >> testGuardedTransition [
	| stateMachine stateA stateB stateC |
	stateMachine := LcsStateMachine new.
	self initCounter.
	
	stateA := (stateMachine addStateNamed: #stateA)
		when: #toB guarded: [counter < 2] to: #stateB;
		endWhen: #exit guarded: [counter >= 3].
		
	stateB := (stateMachine addStateNamed: #stateB).
	stateB activity: [self incrementCounter].
	stateB whenEvent: #toC transitionToState: #stateC.
	stateB whenEvent: #toA transitionToState: #stateA.
		
	stateC := (stateMachine addStateNamed: #stateC).
	stateC exitAction: [self incrementCounter].
	stateC whenEvent: #toB transitionToState: #stateB.
	
	stateMachine setStartStateTo: #stateA.
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #exit.
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #stateB).
	self assert: counter = 1.
	stateMachine handleEvent: #toC.
	stateMachine handleEvent: #toB.
	stateMachine handleEvent: #toA.
	self assert: counter = 3.
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #toB.
	self assert:(stateMachine currentState id = #stateA).
	stateMachine handleEvent: #exit.
	self assert:(stateMachine currentState id = #endState).
]

{ #category : #testing }
LcsStateMachineTest >> testStateMachineContext [
	| stateMachine stateA stateB stateC |
	stateMachine := LcsStateMachine new.
	self initCounter.
	
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
		
	stateMachine setStartStateTo: #stateA.
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
