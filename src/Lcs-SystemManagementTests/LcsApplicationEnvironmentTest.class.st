Class {
	#name : #LcsApplicationEnvironmentTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #tests }
LcsApplicationEnvironmentTest >> testInitializeAndReleaseApplicationEnvironment [
	LcsApplicationEnvironment currentApplicationEnvironment notNil
		ifTrue: [ LcsApplicationEnvironment releaseEnvironment ].
	self assert: LcsApplicationEnvironment singleton isNil.
	self assert: LcsDomainObject hasNoninitializedEnvironment.

	LcsApplicationEnvironment initializeEnvironment.
	self assert: LcsApplicationEnvironment singleton notNil.
	self assert: (LcsApplicationEnvironment currentApplicationEnvironment systemManager
						isKindOf: LcsSystemManager).
	self assert: (LcsApplicationEnvironment currentApplicationEnvironment unitOfWorkManager
						isKindOf: LcsUnitOfWorkManager).
	self assert: LcsDomainObject hasNoninitializedEnvironment.

	LcsApplicationEnvironment releaseEnvironment.
	self assert: LcsApplicationEnvironment singleton isNil.
	self assert: LcsDomainObject hasNoninitializedEnvironment
]
