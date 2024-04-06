Class {
	#name : #LcsSystemSuspendedStatus,
	#superclass : #LcsBaseSystemStatus,
	#category : #'Lcs-DomainBase'
}

{ #category : #testing }
LcsSystemSuspendedStatus >> isInSuspendedStatus [
	^ true
]

{ #category : #'api\t\t' }
LcsSystemSuspendedStatus >> restoreSystem [
	self parent _restoreSystem
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> statusName [
	^ 'Suspended' translated
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> suspendedSystem [
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> toggleActionButtonLabel [
	^ 'Activate'
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> toggleStatus [
	self restoreSystem
]
