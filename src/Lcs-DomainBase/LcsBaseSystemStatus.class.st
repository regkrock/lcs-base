Class {
	#name : 'LcsBaseSystemStatus',
	#superclass : 'LcsDomainObject',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsBaseSystemStatus >> isInActiveStatus [
	^ false
]

{ #category : 'testing' }
LcsBaseSystemStatus >> isInSuspendedStatus [
	^ false
]

{ #category : 'private' }
LcsBaseSystemStatus >> privateParent [
	^ self class slotModel isNil
		ifTrue: [ self instVarNamed: 'parent' ]
		ifFalse: [ self parent]
]

{ #category : 'api' }
LcsBaseSystemStatus >> restoreSystem [
]

{ #category : 'api' }
LcsBaseSystemStatus >> suspendSystem [
]
