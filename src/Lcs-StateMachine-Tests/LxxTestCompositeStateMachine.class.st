Class {
	#name : #LxxTestCompositeStateMachine,
	#superclass : #LcsStateMachine,
	#instVars : [
		'changes'
	],
	#category : #'Lcs-StateMachine-Tests'
}

{ #category : #accessing }
LxxTestCompositeStateMachine >> changes [
	^changes
]

{ #category : #'initialize-release' }
LxxTestCompositeStateMachine >> initialize [
	
	| state2 |
	super initialize.
	
	changes := OrderedCollection new.
	
	(self addStateNamed: #state1) when: #event12 do: [self changes add: 's1->s2'] to: #state2.
	
	state2 := self addStateNamed: #state2.
	state2 subStateMachine: LxxTestSubStateMachine new.
	
	state2 when: #event21 do: [self changes add: 's2->s1'] to: #state1.
	
	self setStartStateToStateNamed: #state1
]
