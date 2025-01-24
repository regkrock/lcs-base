Class {
	#name : #LxxSubStateMachine,
	#superclass : #LcsStateMachine,
	#instVars : [
		'changes'
	],
	#category : #'Lcs-StateMachine-Tests-Test'
}

{ #category : #accessing }
LxxSubStateMachine >> changes [
	^changes
]

{ #category : #'initialize-release' }
LxxSubStateMachine >> initialize [

	super initialize.
	changes := OrderedCollection new.

	(self addStateNamed: #state1) when: #event12 do: [self changes add: 'ss1->ss2'] to: #state2.
	(self addStateNamed: #state2) when: #event21 do: [self changes add: 'ss2->ss1'] to: #state1.
	
	self setStartStateToStateNamed: #state1
]
