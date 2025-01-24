Class {
	#name : #LcsDebugLogger,
	#superclass : #LcsObject,
	#instVars : [
		'actualLogger',
		'isActive'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Lcs-StateMachine'
}

{ #category : #'class initialization' }
LcsDebugLogger class >> default [ 
	default isNil ifTrue: [default := self new].
	^default
]

{ #category : #'class initialization' }
LcsDebugLogger class >> release [
	default := nil
]

{ #category : #accessing }
LcsDebugLogger >> actualLogger [
	^ actualLogger ifNil: [actualLogger := self]
]

{ #category : #accessing }
LcsDebugLogger >> actualLogger: anObject [
	actualLogger := anObject
]

{ #category : #actions }
LcsDebugLogger >> debug: anObject [
	self isActive
		ifTrue: [Transcript cr; show: 'DEBUG> '.
			Transcript show: anObject printString]
]

{ #category : #actions }
LcsDebugLogger >> error: anObject [
	self isActive
		ifTrue: [Transcript cr; show: 'ERROR> '.
			Transcript show: anObject printString]
]

{ #category : #actions }
LcsDebugLogger >> info: anObject [
	self isActive
		ifTrue: [Transcript cr; show: 'INFO> '.
			Transcript show: anObject printString]
]

{ #category : #testing }
LcsDebugLogger >> isActive [
	isActive isNil ifTrue: [isActive := false].
	^isActive
]

{ #category : #accessing }
LcsDebugLogger >> isActive: aBoolean [
	isActive := aBoolean
]

{ #category : #actions }
LcsDebugLogger >> warn: anObject [
	self isActive
		ifTrue: [Transcript cr; show: 'WARN> '.
			Transcript show: anObject printString]
]
