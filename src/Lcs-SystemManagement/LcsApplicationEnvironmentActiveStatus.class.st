Class {
	#name : #LcsApplicationEnvironmentActiveStatus,
	#superclass : #LcsBaseApplicationEnvironmentStatus,
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #printing }
LcsApplicationEnvironmentActiveStatus >> displayString [
	^ self statusName
]

{ #category : #'gt views' }
LcsApplicationEnvironmentActiveStatus >> gtLiveBackground [
	^ BrGlamorousColors successBackgroundColor
]

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
			suspendedSystem: self parent systemsManager suspendCurrentSystem;
			yourself)
]

{ #category : #accessing }
LcsApplicationEnvironmentActiveStatus >> toggleStatus [
	self suspendApplicationEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironmentActiveStatus >> toggleStatusLabel [
	^ 'Stop'
]
