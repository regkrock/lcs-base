Class {
	#name : 'LcsSystemSuspendedStatus',
	#superclass : 'LcsBaseSystemStatus',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsSystemSuspendedStatus >> isInSuspendedStatus [
	^ true
]

{ #category : 'api' }
LcsSystemSuspendedStatus >> restoreSystem [
	self privateParent _restoreSystem
]

{ #category : 'asking' }
LcsSystemSuspendedStatus >> statusName [
	^ 'Suspended' translated
]

{ #category : 'api' }
LcsSystemSuspendedStatus >> suspendedSystem [
]

{ #category : 'asking' }
LcsSystemSuspendedStatus >> toggleActionButtonLabel [
	^ 'Activate'
]

{ #category : 'api' }
LcsSystemSuspendedStatus >> toggleStatus [
	self restoreSystem
]
