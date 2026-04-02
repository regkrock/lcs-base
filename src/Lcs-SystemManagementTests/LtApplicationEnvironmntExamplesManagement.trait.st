Trait {
	#name : 'LtApplicationEnvironmntExamplesManagement',
	#instVars : [
		'suspendedEnvironment'
	],
	#category : 'Lcs-SystemManagementTests-Traits',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Traits'
}

{ #category : 'examples' }
LtApplicationEnvironmntExamplesManagement >> applicationEnvironmentWithCurrentPrototypeSystem [
	<gtExample>
	| environment |
	environment := self newApplicationEnvironmentWithNoSystems.
	self prototypeSystemClass new.
	^ environment
]

{ #category : 'examples' }
LtApplicationEnvironmntExamplesManagement >> newApplicationEnvironmentWithNoSystems [
	<gtExample>
	| environment |
	self suspendedCurrentApplicationEnvironment.
	environment := LcsApplicationEnvironment initializeApplicationEnvironment.
	self validationInitializedApplicationEnvironment.
	^ environment 
]

{ #category : 'prvate' }
LtApplicationEnvironmntExamplesManagement >> prototypeSystemClass [
	^ 'LxxPrototypeSystem' asClass
]

{ #category : 'environment' }
LtApplicationEnvironmntExamplesManagement >> restoreSuspendedApplicationEnvironment [
	LcsApplicationEnvironment
		restoreToCurrentApplicationEnvironment: self suspendedEnvironment.
	self suspendedEnvironment ifNotNil: [ 
		self assert: self suspendedEnvironment isInActiveStatus.
		self assert: self suspendedEnvironment
						== LcsApplicationEnvironment currentApplicationEnvironment ].
	^ LcsApplicationEnvironment currentApplicationEnvironment
]

{ #category : 'environment' }
LtApplicationEnvironmntExamplesManagement >> suspendedCurrentApplicationEnvironment [
	<gtExample>
	<after: #restoreSuspendedApplicationEnvironment>
	self suspendedEnvironment: LcsApplicationEnvironment suspendApplicationEnvironment.
	self suspendedEnvironment
		ifNotNil: [ 
			self assert: self suspendedEnvironment isInSuspendedStatus .
			self validateApplicationEnvironmentIsNotInitialized ].
	^ self suspendedEnvironment
]

{ #category : 'accessing' }
LtApplicationEnvironmntExamplesManagement >> suspendedEnvironment [
	^ suspendedEnvironment
]

{ #category : 'accessing' }
LtApplicationEnvironmntExamplesManagement >> suspendedEnvironment: anObject [
	suspendedEnvironment := anObject
]

{ #category : 'validation' }
LtApplicationEnvironmntExamplesManagement >> validateApplicationEnvironmentIsNotInitialized [
	self assert: LcsApplicationEnvironment isStopped.
	self assert: LcsApplicationEnvironment singleton isNil.
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

{ #category : 'validation' }
LtApplicationEnvironmntExamplesManagement >> validateInitializedUnitsOfWorkManager: aUnitsOfWorkManager [ 
	self assert: (aUnitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: aUnitsOfWorkManager notNil.
	self assert: aUnitsOfWorkManager currentUnitOfWork isNil.
	self deny: aUnitsOfWorkManager hasCurrentUnitOfWork.
	self assert: aUnitsOfWorkManager unitsOfWork hasNoElements.
	self assert: aUnitsOfWorkManager parent == LcsApplicationEnvironment singleton.
	self assert: aUnitsOfWorkManager numberOfUnitsOfWork equals: 0
]

{ #category : 'valitdation' }
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
