Class {
	#name : #LcsStateMachineObject,
	#superclass : #LcsDomainObject,
	#instVars : [
		'id',
		'stateMachine',
		'currentEvent'
	],
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #'instance creation' }
LcsStateMachineObject class >> id: anId [
	^self new id: anId
]

{ #category : #comparing }
LcsStateMachineObject >> = other [
	self class = other class ifFalse: [^false].
	^self id = other id
]

{ #category : #'actions-event' }
LcsStateMachineObject >> context [
	^self stateMachine ifNotNil:[ self stateMachine context ]
]

{ #category : #accessing }
LcsStateMachineObject >> currentEvent [
	^ currentEvent
]

{ #category : #accessing }
LcsStateMachineObject >> currentEvent: anObject [
	currentEvent := anObject
]

{ #category : #debugging }
LcsStateMachineObject >> debug: anObject [ 
	LcsDebugLogger default debug: anObject
]

{ #category : #comparing }
LcsStateMachineObject >> hash [
	^self id hash
]

{ #category : #accessing }
LcsStateMachineObject >> id [
	^ id ifNil: [id := UUID new asString36]
]

{ #category : #accessing }
LcsStateMachineObject >> id: anObject [
	id := anObject
]

{ #category : #'initialize-release' }
LcsStateMachineObject >> initialize [
	super initialize
]

{ #category : #printing }
LcsStateMachineObject >> printOn: aStream [
	aStream nextPutAll: self className.
	aStream nextPutAll: ' (', self id , ')'
]

{ #category : #accessing }
LcsStateMachineObject >> stateMachine [
	^stateMachine
]

{ #category : #accessing }
LcsStateMachineObject >> stateMachine: aStateMachine [
	stateMachine := aStateMachine
]
