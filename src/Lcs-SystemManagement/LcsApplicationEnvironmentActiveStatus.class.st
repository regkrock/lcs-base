Class {
	#name : #LcsApplicationEnvironmentActiveStatus,
	#superclass : #LcsBaseApplicationEnvironmentStatus,
	#category : #'Lcs-SystemManagement'
}

{ #category : #testing }
LcsApplicationEnvironmentActiveStatus >> isInActiveStatus [
	^ true
]

{ #category : #accessing }
LcsApplicationEnvironmentActiveStatus >> statusName [
	^ 'Active' translated
]

{ #category : #api }
LcsApplicationEnvironmentActiveStatus >> suspendApplicationEnvironment [
	self parent status: (
		(LcsApplicationEnvironmentSuspendedStatus newOn: self parent)
			suspendedSystem: self parent systemManager suspendCurrentSystem;
			yourself)
]
