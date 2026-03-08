Extension { #name : 'LcsApplicationEnvironmentExamples' }

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> _createAndRemoveUnitOfWork [
	| unistOfWorkManager unitOfWork |
	self _newApplicationEnvironment.
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
LcsApplicationEnvironmentExamples >> _createUnitOfWorkOnNilSystem [
	| unitOfWork |
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.
	unitOfWork := LcsApplicationEnvironment createUnitOfWork.
	self assert: unitOfWork class identicalTo: LcsUnitOfWork.
	^ unitOfWork
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> _deleteCurrentSystemAndMakeOtherCurrent [
	| secondSystem firstSystem |
	self _newApplicationEnvironmentWithCurrentSystem.
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
LcsApplicationEnvironmentExamples >> _newApplicationEnvironmentWithCurrentSystem [
	self _newApplicationEnvironment.
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
LcsApplicationEnvironmentExamples >> _swapSystems [
	| secondSystem firstSystem |
	self _newApplicationEnvironmentWithCurrentSystem.
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

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> addToUnitOfWorkCollections [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _addToUnitOfWorkCollections ]
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
	^ self inNewEnvironmentDo: [ self _newApplicationEnvironmentWithCurrentSystem ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createSystemsAndSwapThem [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _swapSystems ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> createSystemsDeleteTheCurrentAndMakeOtherCurrent [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _deleteCurrentSystemAndMakeOtherCurrent ]
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsApplicationEnvironmentExamples >> removingFromChangedCollections [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _removingFromChangedCollections ]
]
