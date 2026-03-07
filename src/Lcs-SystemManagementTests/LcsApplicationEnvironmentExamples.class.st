Class {
	#name : 'LcsApplicationEnvironmentExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _createInstanceOfDomainObject [
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ LcsDomainObject new ] raise: LcsSlotModelNotInitializedError.
	self should: [ LxxPrototypeSystem verifySlotModelInitialized ] raise: LcsSlotModelNotInitializedError
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> createNewApplicationEnvironment [
	<gtExample>
	^ self inNewEnvironmentDo: [ self newApplicationEnvironment ]
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> inNewEnvironmentDo: aBlock [
	| suspendedEnvironment |
	suspendedEnvironment := LcsApplicationEnvironment suspendApplicationEnvironment.
	self assert: suspendedEnvironment isInSuspendedStatus.
	self validateApplicationEnvironmentIsNotInitialized.
	[ aBlock cull: suspendedEnvironment ]
		ensure: [ 
			LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: suspendedEnvironment ].
	self assert: suspendedEnvironment isInActiveStatus.
	^ suspendedEnvironment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> newApplicationEnvironment [
	self assert: LcsApplicationEnvironment isStopped.
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self validationInitializedApplicationEnvironment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> validateApplicationEnvironmentIsNotInitialized [
	self assert: LcsApplicationEnvironment currentApplicationEnvironment isNil.
	self assert: LcsApplicationEnvironment hasNoninitializedApplicationEnvironment.
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
	self assert: LcsApplicationEnvironment unitsOfWorkManager isNil.
	self 
		should: [LcsApplicationEnvironment verifyApplicationEnvironment] 
		raise: LcsApplicationEnivronmentNotInitializedError.
	self assert: LcsApplicationObject currentSystem isNil.
	self assert: LcsApplicationObject new currentSystem isNil.
	self assert: LcsApplicationObject currentUnitOfWork isNil.
	self assert: LcsBaseDomainObject hasNoninitializedSlotModel equals: true.
	self assert: LcsApplicationObject new currentUnitOfWork isNil
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> validateInitializedUnitsOfWorkManager: aUnitsOfWorkManager [ 
	self assert: (aUnitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: aUnitsOfWorkManager notNil.
	self assert: aUnitsOfWorkManager currentUnitOfWork isNil.
	self deny: aUnitsOfWorkManager hasCurrentUnitOfWork.
	self assert: aUnitsOfWorkManager unitsOfWork hasNoElements.
	self assert: aUnitsOfWorkManager parent == LcsApplicationEnvironment singleton.
	self assert: aUnitsOfWorkManager numberOfUnitsOfWork equals: 0
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> validationInitializedApplicationEnvironment [
	self assert: LcsApplicationEnvironment isRunning.
	self assert: LcsApplicationEnvironment hasNoCurrentSystem.
	self assert: LcsApplicationEnvironment hasNoCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasNoCurrentSystem.
	self assert: LcsApplicationEnvironment hasNoCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment hasSystemsManager.
	self assert: LcsApplicationEnvironment hasUnitsOfWorkManager.
	self assert: LcsApplicationEnvironment isInActiveStatus.
	self assert: (LcsApplicationEnvironment systemsManager isKindOf: LcsSystemsManager).
	self assert: (LcsApplicationEnvironment unitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self shouldnt: [LcsApplicationEnvironment verifyApplicationEnvironment] raise: LcsApplicationEnivronmentNotInitializedError.
	self validateInitializedUnitsOfWorkManager: LcsApplicationEnvironment unitsOfWorkManager
]
