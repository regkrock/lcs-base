Class {
	#name : #LcsApplicationEnvironmentTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #tests }
LcsApplicationEnvironmentTest >> testInitializeAndReleaseApplicationEnvironment [
	self assert: LcsApplicationEnvironment hasNoninitializedEnvironment.
	self assert: LcsObject hasNoninitializedEnvironment.

	LcsApplicationEnvironment initializeEnvironment.
	self assert: LcsApplicationEnvironment singleton notNil.
	self assert: (LcsApplicationEnvironment systemManager isKindOf: LcsSystemManager).
	self assert: (LcsApplicationEnvironment unitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: LcsObject hasNoninitializedEnvironment.

	LcsApplicationEnvironment releaseApplicationEnvironment.
	self assert: LcsApplicationEnvironment singleton isNil.
	self assert: LcsObject hasNoninitializedEnvironment
]
