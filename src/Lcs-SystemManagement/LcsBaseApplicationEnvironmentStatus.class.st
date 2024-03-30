Class {
	#name : #LcsBaseApplicationEnvironmentStatus,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'instance creation' }
LcsBaseApplicationEnvironmentStatus class >> newOn: anApplicationEnvironment [ 
	^ self new
		initializeOn: anApplicationEnvironment;
		yourself
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> initializeOn: anApplicationEnvironment [ 
	self parent: anApplicationEnvironment
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInActiveStatus [
	^ false
]

{ #category : #testing }
LcsBaseApplicationEnvironmentStatus >> isInSuspendedStatus [
	^ false
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> parent [
	^ parent
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> parent: anApplicationEnvironment [ 
	parent := anApplicationEnvironment
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> restoreEnvironment [
]

{ #category : #api }
LcsBaseApplicationEnvironmentStatus >> suspendEnvironment [
]
