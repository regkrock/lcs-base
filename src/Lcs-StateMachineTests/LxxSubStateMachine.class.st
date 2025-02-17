Class {
	#name : #LxxSubStateMachine,
	#superclass : #LcsStateMachine,
	#instVars : [
		'changes'
	],
	#category : #'Lcs-StateMachineTests-Support'
}

{ #category : #'slot definitions' }
LxxSubStateMachine class >> changesSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : #accessing }
LxxSubStateMachine >> changes [
	^ self slotVarNamed: 'changes'
]

{ #category : #accessing }
LxxSubStateMachine >> changes: anObject [
	self slotVarNamed: 'changes' put: anObject
]

{ #category : #'initialize-release' }
LxxSubStateMachine >> initialize [

	super initialize.
	"changes := OrderedCollection new."

	(self addStateNamed: #state1) when: #event12 do: [self changes add: 'ss1->ss2'] to: #state2.
	(self addStateNamed: #state2) when: #event21 do: [self changes add: 'ss2->ss1'] to: #state1.
	
	self setStartStateToStateNamed: #state1
]
