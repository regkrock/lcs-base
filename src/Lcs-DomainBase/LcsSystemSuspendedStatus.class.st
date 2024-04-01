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
	self parent
		restoreUnitOfWork;
		restoreSlotModel;
		status: (LcsSystemActiveStatus newOn: self parent)
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> statusName [
	^ 'Suspended' translated
]

{ #category : #accessing }
LcsSystemSuspendedStatus >> suspendedSystem [
]
