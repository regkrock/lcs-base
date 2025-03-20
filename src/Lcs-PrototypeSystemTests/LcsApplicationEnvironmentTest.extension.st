Extension { #name : #LcsApplicationEnvironmentTest }

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentTest >> testAddingSystenToApplicationEnvironment [
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	self assert: subject systemsManager numberOfSystems equals: 0.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	self assert: subject systemsManager numberOfSystems equals: 1.
	self assert: subject currentSystem class identicalTo: LxxPrototypeSystem.
	self assert: subject unitsOfWorkManager numberOfUnitsOfWork equals: 1.
	self assert: subject currentUnitOfWork class identicalTo: LcsUnitOfWork.
	self assert: subject hasCurrentSystem.
	self assert: subject hasCurrentUnitOfWork.
]

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentTest >> testDeletingCurrentSystemAndMakingSuspendedSystemCurrentViaApplicationEnvironment [
	| system temporarySystem |
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	system := subject currentSystem.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	temporarySystem := subject currentSystem.
	
	subject deleteCurrentAndMakeCurrent: system.
	self assert: subject currentSystem identicalTo: system.
	self assert: system isInActiveStatus.
	self assert: (subject systemsManager systems includes: system).
	self deny:(subject systemsManager systems includes: temporarySystem).
]

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentTest >> testMakingSuspendedSystemCurrentViaApplicationEnvironment [
	| system |
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	system := subject currentSystem.
	subject suspendCurrentSystem.
	
	subject makeSystemCurrent: system.
	
	self assert: subject currentSystem identicalTo: system.
	self assert: system isInActiveStatus
]

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentTest >> testSuspendingCurrentSystemViaApplicationEnvironment [
	| system |
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	system := subject currentSystem.
	self assert: system isInActiveStatus.
	
	subject suspendCurrentSystem.
	
	self assert: subject currentSystem isNil.
	self assert: system isInSuspendedStatus
]
