Trait {
	#name : 'LtApplicationEnvironmntExamplesManagement',
	#category : 'Lcs-SystemManagementTests-Traits',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Traits'
}

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> inNewEnvironmentDo: aBlock [
	| suspendedEnvironment |
	suspendedEnvironment := self suspendedApplicationEnvironment.
	[ aBlock cull: suspendedEnvironment ]
		ensure: [ self restoreEnvironment: suspendedEnvironment ].
	^ suspendedEnvironment
]

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> restoreEnvironment: aSuspendedEnvironment [
	LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: aSuspendedEnvironment.
	aSuspendedEnvironment ifNotNil: [
		self assert: aSuspendedEnvironment isInActiveStatus ].
	aSuspendedEnvironment
]

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> suspendedApplicationEnvironment [
	| suspendedEnvironment |
	^ LcsApplicationEnvironment suspendApplicationEnvironment 
		ifNotNil: [ 
			suspendedEnvironment := LcsApplicationEnvironment suspendApplicationEnvironment.
			self assert: suspendedEnvironment isInSuspendedStatus.
			self validateApplicationEnvironmentIsNotInitialized.
			suspendedEnvironment ]
]

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> validateApplicationEnvironmentIsNotInitialized [
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

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> validateInitializedUnitsOfWorkManager: aUnitsOfWorkManager [ 
	self assert: (aUnitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: aUnitsOfWorkManager notNil.
	self assert: aUnitsOfWorkManager currentUnitOfWork isNil.
	self deny: aUnitsOfWorkManager hasCurrentUnitOfWork.
	self assert: aUnitsOfWorkManager unitsOfWork hasNoElements.
	self assert: aUnitsOfWorkManager parent == LcsApplicationEnvironment singleton.
	self assert: aUnitsOfWorkManager numberOfUnitsOfWork equals: 0
]

{ #category : 'as yet unclassified' }
LtApplicationEnvironmntExamplesManagement >> validationInitializedApplicationEnvironment [
	| systemsManager |
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
	self validateInitializedUnitsOfWorkManager: LcsApplicationEnvironment unitsOfWorkManager.
	self assert: LcsApplicationEnvironment systemsManager applicationEnvironment equals:  LcsApplicationEnvironment singleton.
	
	systemsManager := LcsApplicationEnvironment systemsManager.
	self assert: systemsManager parent equals: LcsApplicationEnvironment singleton.
	self assert: systemsManager numberOfSystems equals: 0.
	self assert:systemsManager currentSystem isNil.
	self assert: systemsManager systems hasNoElements.
	systemsManager removeCurrentSystem.
	self assert: systemsManager numberOfSystems equals: 0.
	systemsManager suspendCurrentSystem.
	self assert: systemsManager numberOfSystems equals: 0.
	systemsManager releaseApplicationEnvironment.
	self assert: systemsManager numberOfSystems equals: 0.
	self assert:systemsManager currentUnitOfWork isNil.
	self assert: systemsManager hasNoSystems.
	self deny: systemsManager hasSystems.
	self assert: systemsManager hasNoCurrentSystem.
	self deny: systemsManager hasCurrentSystem
]
