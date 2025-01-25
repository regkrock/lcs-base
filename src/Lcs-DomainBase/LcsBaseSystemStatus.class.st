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

{ #category : #private }
LcsBaseSystemStatus >> privateParent [
	^ self class slotModel isNil
		ifTrue: [ self instVarNamed: 'parent' ]
		ifFalse: [ self parent]
]

{ #category : #api }
LcsBaseSystemStatus >> restoreSystem [
]

{ #category : #api }
LcsBaseSystemStatus >> suspendSystem [
]
