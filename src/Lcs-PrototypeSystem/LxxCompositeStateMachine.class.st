Class {
	#name : 'LxxCompositeStateMachine',
	#superclass : 'LcsStateMachine',
	#instVars : [
		'changes'
	],
	#category : 'Lcs-PrototypeSystem-Support',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Support'
}

{ #category : 'slot definitions' }
LxxCompositeStateMachine class >> changesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : 'accessing' }
LxxCompositeStateMachine >> changes [
	^ self slotVarNamed: 'changes'
]

{ #category : 'initialize-release' }
LxxCompositeStateMachine >> changes: anObject [
	self slotVarNamed: 'changes' put: anObject
]

{ #category : 'initialize-release' }
LxxCompositeStateMachine >> initialize [
	
	| state2 |
	super initialize.
	
	"self changes: OrderedCollection new."
	
	(self addStateNamed: #state1) when: #event12 do: [self changes add: 's1->s2'] to: #state2.
	
	state2 := self addStateNamed: #state2.
	state2 subStateMachine: LxxSubStateMachine new.
	
	state2 when: #event21 do: [self changes add: 's2->s1'] to: #state1.
	
	self setStartStateToStateNamed: #state1
]
