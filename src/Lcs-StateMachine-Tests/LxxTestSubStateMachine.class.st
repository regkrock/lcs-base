Class {
	#name : #LxxTestSubStateMachine,
	#superclass : #LcsStateMachine,
	#instVars : [
		'changes'
	],
	#category : #'Lcs-StateMachine-Tests'
}

{ #category : #accessing }
LxxTestSubStateMachine >> changes [
	^changes
]

{ #category : #'initialize-release' }
LxxTestSubStateMachine >> initialize [

	super initialize.
	changes := OrderedCollection new.

	(self addStateNamed: #state1) when: #event12 do: [self changes add: 'ss1->ss2'] to: #state2.
	(self addStateNamed: #state2) when: #event21 do: [self changes add: 'ss2->ss1'] to: #state1.
	
	self setStartStateToStateNamed: #state1
]
