Class {
	#name : 'LcsStateMachineEvent',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'handled',
		'arguments',
		'type'
	],
	#category : 'Lcs-StateMachine-Core',
	#package : 'Lcs-StateMachine',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsStateMachineEvent class >> argumentsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'arguments';
		yourself
]

{ #category : 'slot definitions' }
LcsStateMachineEvent class >> handledSlotDefinition [
	<accessorSlotDefinition>
	^ LcsBooleanSlot new
		slotName: 'handled';
		initialValue: false;
		yourself
]

{ #category : 'instance creation' }
LcsStateMachineEvent class >> newType: aSymbol [
	^self newType: aSymbol arguments: #()
]

{ #category : 'instance creation' }
LcsStateMachineEvent class >> newType: aSymbol arguments: args [
	^self new 
		initializeType: aSymbol arguments: args
		yourself
]

{ #category : 'slot definitions' }
LcsStateMachineEvent class >> typeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStateMachineEventTypeSlot new
]

{ #category : 'initialize' }
LcsStateMachineEvent >> arguments [
	^arguments
]

{ #category : 'accessing' }
LcsStateMachineEvent >> arguments: anArray [
	arguments := anArray
]

{ #category : 'accessing' }
LcsStateMachineEvent >> handled [
	^ handled
]

{ #category : 'accessing' }
LcsStateMachineEvent >> handled: aBoolean [
	handled := aBoolean
]

{ #category : 'initialize' }
LcsStateMachineEvent >> initializeType: aSymbol arguments: args [
	self type: aSymbol.
	self arguments addAll: args
]

{ #category : 'printing' }
LcsStateMachineEvent >> printOn: aStream [
	aStream nextPutAll: 'Event: '.
	aStream space.
	aStream nextPutAll: self type asString.
	aStream space.
	aStream nextPutAll: self arguments printString.
]

{ #category : 'accessing' }
LcsStateMachineEvent >> type [
	^type
]

{ #category : 'accessing' }
LcsStateMachineEvent >> type: aSymbol [
	type := aSymbol
]
