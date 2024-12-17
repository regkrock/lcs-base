Class {
	#name : #LcsStateMachineEvent,
	#superclass : #LcsDomainObject,
	#instVars : [
		'handled',
		'arguments',
		'type'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'instance creation' }
LcsStateMachineEvent class >> type: aSymbol [
	^self type: aSymbol arguments: nil
]

{ #category : #'instance creation' }
LcsStateMachineEvent class >> type: aSymbol arguments: args [
	^self new type: aSymbol; arguments: args; yourself
]

{ #category : #accessing }
LcsStateMachineEvent >> arguments [
	arguments isNil ifTrue:[arguments := Array new].
	^arguments
]

{ #category : #accessing }
LcsStateMachineEvent >> arguments: anArray [
	arguments := anArray
]

{ #category : #accessing }
LcsStateMachineEvent >> handled [
	handled isNil ifTrue:[handled := false].
	^handled
]

{ #category : #accessing }
LcsStateMachineEvent >> handled: aBoolean [
	handled := aBoolean
]

{ #category : #printing }
LcsStateMachineEvent >> printOn: aStream [
	aStream nextPutAll: 'Event: '.
	aStream space.
	aStream nextPutAll: self type asString.
	aStream space.
	aStream nextPutAll: self arguments printString.
]

{ #category : #accessing }
LcsStateMachineEvent >> type [
	^type
]

{ #category : #accessing }
LcsStateMachineEvent >> type: aSymbol [
	type := aSymbol
]
