Class {
	#name : 'LcsApplicationEnvironmentTest',
	#superclass : 'LcsTestWithNoApplicationEnvironmentTest',
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testInitializedApplicationEnvironment [
	self assert: LcsApplicationEnvironment currentApplicationEnvironment isNil.
	LcsApplicationEnvironment initializeApplicationEnvironment .

	self assert: LcsApplicationEnvironment currentApplicationEnvironment notNil.
	self deny: LcsApplicationEnvironment hasCurrentSystem.
	self deny: LcsApplicationEnvironment hasCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasNoCurrentSystem.
	self assert: LcsApplicationEnvironment hasNoCurrentUnitOfWork.
	self deny: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasSystemsManager.
	self assert: LcsApplicationEnvironment hasUnitsOfWorkManager.
	self assert: LcsApplicationEnvironment isInActiveStatus.
	
	self assert: (LcsApplicationEnvironment systemsManager isKindOf: LcsSystemsManager).
	self assert: (LcsApplicationEnvironment unitsOfWorkManager isKindOf: LcsUnitsOfWorkManager)
]

{ #category : 'test' }
LcsApplicationEnvironmentTest >> testNoninitializedApplicationEnvironment [
	self assert: LcsApplicationEnvironment currentApplicationEnvironment isNil.

	self deny: LcsApplicationEnvironment hasCurrentSystem.
	self deny: LcsApplicationEnvironment hasCurrentUnitOfWork.
	self deny: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasNoCurrentSystem.
	self assert: LcsApplicationEnvironment hasNoCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	self deny: LcsApplicationEnvironment hasSystemsManager.
	self deny: LcsApplicationEnvironment hasUnitsOfWorkManager.
	self deny: LcsApplicationEnvironment isInActiveStatus.
	
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment systemsManager isNil.
	self assert: LcsApplicationEnvironment unitsOfWorkManager isNil
]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testReleaseApplicationEnvironment [
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.

	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.

	LcsApplicationEnvironment releaseApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment
]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testResetingAnApplicationEnvironment [
	| environment |
	LcsApplicationEnvironment initializeApplicationEnvironment.
	environment := LcsApplicationEnvironment currentApplicationEnvironment.
	LcsApplicationEnvironment resetApplicationEnvironment.
	
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self deny: LcsApplicationEnvironment currentApplicationEnvironment == environment.

]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testRestoringSuspendedApplicationEnvironment [
	| suspendedEnvironment |
	LcsApplicationEnvironment initializeApplicationEnvironment.

	suspendedEnvironment := LcsApplicationEnvironment suspendApplicationEnvironment.
	self assert: suspendedEnvironment isInSuspendedStatus.
	
	LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: suspendedEnvironment.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self assert: suspendedEnvironment isInActiveStatus
]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testSuspendingAnApplicationEnvironment [
	| suspendedEnvironment |
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.

	suspendedEnvironment := LcsApplicationEnvironment suspendApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	self assert: suspendedEnvironment class == LcsApplicationEnvironment.
	self assert: suspendedEnvironment isInSuspendedStatus
]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testSuspendingCurrentSystemWhenNoSystemExists [
	| suspendedSystem |
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment systemsManager hasNoSystems.

	suspendedSystem := LcsApplicationEnvironment suspendCurrentSystem.
	self assert: suspendedSystem isNil.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.

]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testVerifyApplicationEnvironmentIsInitialized [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self shouldnt: [LcsApplicationEnvironment verifyApplicationEnvironment] raise: LcsApplicationEnivronmentNotInitializedError

]

{ #category : 'tests' }
LcsApplicationEnvironmentTest >> testVerifyApplicationEnvironmentIsNotInitialized [
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
	self should: [LcsApplicationEnvironment verifyApplicationEnvironment] 
			raise: LcsApplicationEnivronmentNotInitializedError

]
