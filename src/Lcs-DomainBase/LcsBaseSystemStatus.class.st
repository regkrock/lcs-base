Class {
	#name : #LcsBaseSystemStatus,
	#superclass : #LcsDomainObject,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #testing }
LcsBaseSystemStatus >> isInActiveStatus [
	^ false
]

{ #category : #testing }
LcsBaseSystemStatus >> isInSuspendedStatus [
	^ false
]

{ #category : #api }
LcsBaseSystemStatus >> restoreSystem [
]

{ #category : #api }
LcsBaseSystemStatus >> suspendSystem [
]
