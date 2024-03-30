Class {
	#name : #LcsApplicationEnvironmentActiveStatus,
	#superclass : #LcsBaseApplicationEnvironmentStatus,
	#category : #'Lcs-SystemManagement'
}

{ #category : #testing }
LcsApplicationEnvironmentActiveStatus >> isInActiveStatus [
	^ true
]

{ #category : #api }
LcsApplicationEnvironmentActiveStatus >> suspendEnvironment [
	self parent status: (
		(LcsApplicationEnvironmentSuspendedStatus newOn: self parent)
			suspendedSystem: self parent systemManager suspendCurrentSystem;
			yourself)
]
