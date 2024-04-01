Class {
	#name : #LcsSystemActiveStatus,
	#superclass : #LcsBaseSystemStatus,
	#category : #'Lcs-DomainBase'
}

{ #category : #testing }
LcsSystemActiveStatus >> isInActiveStatus [
	^ true
]

{ #category : #accessing }
LcsSystemActiveStatus >> statusName [
	^ 'Active' translated
]

{ #category : #api }
LcsSystemActiveStatus >> suspendSystem [
	self parent 
		releaseSlotModel;
		suspendUnitOfWork;
		status: (LcsSystemSuspendedStatus newOn: self parent)
]
