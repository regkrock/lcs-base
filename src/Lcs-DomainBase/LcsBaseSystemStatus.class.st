Class {
	#name : #LcsBaseSystemStatus,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'instance creation' }
LcsBaseSystemStatus class >> newOn: aSystem [ 
	^ self new
		initializeOn: aSystem;
		yourself
]

{ #category : #api }
LcsBaseSystemStatus >> initializeOn: aSystem [ 
	self parent: aSystem
]

{ #category : #testing }
LcsBaseSystemStatus >> isInActiveStatus [
	^ false
]

{ #category : #testing }
LcsBaseSystemStatus >> isInSuspendedStatus [
	^ false
]

{ #category : #api }
LcsBaseSystemStatus >> parent [
	^ parent
]

{ #category : #api }
LcsBaseSystemStatus >> parent: aSystem [ 
	parent := aSystem
]

{ #category : #api }
LcsBaseSystemStatus >> restoreSystem [
]

{ #category : #api }
LcsBaseSystemStatus >> suspendSystem [
]
