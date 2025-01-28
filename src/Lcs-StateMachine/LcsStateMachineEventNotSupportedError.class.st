Class {
	#name : #LcsStateMachineEventNotSupportedError,
	#superclass : #Warning,
	#instVars : [
		'event',
		'state'
	],
	#category : #'Lcs-StateMachine-Error'
}

{ #category : #'instance creation' }
LcsStateMachineEventNotSupportedError class >> event: anEvent state: aState [
	^self new event: anEvent; state: aState; yourself
]

{ #category : #exceptionDescription }
LcsStateMachineEventNotSupportedError >> defaultAction [
	
	^nil
]

{ #category : #accessing }
LcsStateMachineEventNotSupportedError >> event [
	^ event
]

{ #category : #accessing }
LcsStateMachineEventNotSupportedError >> event: anObject [
	event := anObject
]

{ #category : #accessing }
LcsStateMachineEventNotSupportedError >> state [
	^ state
]

{ #category : #accessing }
LcsStateMachineEventNotSupportedError >> state: anObject [
	state := anObject
]
