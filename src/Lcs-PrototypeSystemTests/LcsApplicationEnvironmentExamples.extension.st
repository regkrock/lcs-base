Extension { #name : 'LcsApplicationEnvironmentExamples' }

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> _createAndRemoveUnitOfWork [
	| unistOfWorkManager unitOfWork |
	self newApplicationEnvironment.
	unistOfWorkManager := LcsApplicationEnvironment unitsOfWorkManager.
	self assert: unistOfWorkManager numberOfUnitsOfWork equals: 0.
	unitOfWork := unistOfWorkManager createUnitOfWorkForCurrentSystem.
	self assert: unistOfWorkManager currentUnitOfWork identicalTo: unitOfWork.
	self assert: unistOfWorkManager numberOfUnitsOfWork equals: 1.
	unistOfWorkManager removeCurrentUnitOfWork.
	self assert: unistOfWorkManager currentUnitOfWork identicalTo:nil.
	self assert: unistOfWorkManager unitsOfWork hasNoElements
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createAndRemoveUnitOfWork [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _createAndRemoveUnitOfWork ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createInstanceOfDomainObject [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _createInstanceOfDomainObject ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createNewApplicationEnvironmentWithCurrentSystem [
	<gtExample>
	^ self inNewEnvironmentDo: [ self newApplicationEnvironmentWithCurrentSystem ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createSystemsAndSwapThem [
	<gtExample>
	^ self inNewEnvironmentDo: [ self swapSystems ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createSystemsDeleteTheCurrentAndMakeOtherCurrent [
	<gtExample>
	^ self inNewEnvironmentDo: [ self deleteCurrentSystemAndMakeOtherCurrent ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> deleteCurrentSystemAndMakeOtherCurrent [
	| secondSystem firstSystem |
	self newApplicationEnvironmentWithCurrentSystem.
	firstSystem := LcsApplicationEnvironment currentSystem.
	secondSystem := LcsApplicationEnvironment createCurrentSystemFor: LxxPrototypeSystem.
	self assert: LcsApplicationEnvironment currentSystem identicalTo: secondSystem.
	self assert: firstSystem ~~ secondSystem.
	LcsApplicationEnvironment deleteCurrentAndMakeCurrent: firstSystem.
	self assert: LcsApplicationEnvironment currentSystem identicalTo: firstSystem.
	self assert: firstSystem isInActiveStatus.
	self assert: (LcsApplicationEnvironment systemsManager systems includes: firstSystem).
	^ self deny: (LcsApplicationEnvironment systemsManager systems includes: secondSystem)
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> newApplicationEnvironmentWithCurrentSystem [
	self newApplicationEnvironment.
	LcsApplicationEnvironment createCurrentSystemFor: LxxPrototypeSystem.
	self assert: LcsApplicationEnvironment systemsManager numberOfSystems equals: 1.
	self
		assert: LcsApplicationEnvironment currentSystem class
		identicalTo: LxxPrototypeSystem.
	self
		assert: LcsApplicationEnvironment unitsOfWorkManager numberOfUnitsOfWork
		equals: 1.
	self
		assert: LcsApplicationEnvironment currentUnitOfWork class
		identicalTo: LcsUnitOfWork.
	self assert: LcsApplicationEnvironment hasCurrentSystem.
	self assert: LcsApplicationEnvironment hasCurrentUnitOfWork.
	^ LcsApplicationEnvironment currentApplicationEnvironment
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> swapSystems [
	| secondSystem firstSystem |
	self newApplicationEnvironmentWithCurrentSystem.
	firstSystem := LcsApplicationEnvironment currentSystem.
	secondSystem := LcsApplicationEnvironment createCurrentSystemFor: LxxPrototypeSystem.
	self assert: LcsApplicationEnvironment currentSystem identicalTo: secondSystem.
	self assert: firstSystem ~~ secondSystem.
	self assert: firstSystem isInSuspendedStatus.
	self assert: secondSystem isInActiveStatus.
	
	LcsApplicationEnvironment makeSystemCurrent: firstSystem.
	self assert: firstSystem isInActiveStatus.
	self assert: secondSystem isInSuspendedStatus.

	LcsApplicationEnvironment makeSystemCurrent: secondSystem.
	self assert: firstSystem isInSuspendedStatus.
	self assert: secondSystem isInActiveStatus.

]
