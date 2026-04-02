Class {
	#name : 'LcsApplicationEnvironmentExamples',
	#superclass : 'LcsExamples',
	#traits : 'LtApplicationEnvironmntExamplesManagement',
	#classTraits : 'LtApplicationEnvironmntExamplesManagement classTrait',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> addToUnitOfWorkCollections [
	<gtExample>
	<after: #restoreSuspendedApplicationEnvironment>
	| unitOfWork |
	self uninitializedApplicationEnvironment.
	unitOfWork := LcsUnitOfWorkExamples new newUnitOfWork.
	unitOfWork addPendingAddOf: 'aaaa' to: 'bbb'.
	self assert: (unitOfWork changedCollections keys includes: 'bbb').
	self assert: (unitOfWork _pendingAddsIn: 'bbb') class equals: OrderedCollection.
	self assert: ((unitOfWork pendingAddsIn: 'bbb') includes: 'aaaa').
	
	self assert: unitOfWork changedCollections notEmpty.
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'add') includes: 'aaaa').
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'delete') isEmpty).
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	^ unitOfWork
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> applicationEnvironmentWithCurrentBasicSystemAndSuspendedPrototypeSystem [
	<gtExample>
	| environment |
	environment := self applicationEnvironmentWithCurrentPrototypeSystem.
	self createNewSystem: self basicSystemClass in: environment.
	^ environment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> applicationEnvironmentWithCurrentPrototypeSystem [
	<gtExample>
	| environment |
	environment := self newApplicationEnvironmentWithNoSystems.
	self createNewSystem: self prototypeSystemClass in: environment.
	^ environment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> applicationEnvironmentWithCurrentSystemDeletedAndSuspendedSystemMadeCurrent [
	<gtExample>
	| environment basicSystem prototypeSystem |
	environment := self applicationEnvironmentWithCurrentBasicSystemAndSuspendedPrototypeSystem.
	basicSystem := environment currentSystem.
	prototypeSystem := environment systemsManager suspendedSystemFor: self prototypeSystemClass. 
	environment deleteCurrentAndMakeCurrent: prototypeSystem.
	self assert: (environment currentSystem isKindOf: self prototypeSystemClass).
	self assert: environment currentSystem isInActiveStatus.
	self assert: (environment systemsManager systems includes: environment currentSystem).
	self deny: (environment systemsManager systems includes: basicSystem).
	^ environment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> basicSystemClass [
	^ LcsBasicSystem
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> createNewBasicSystemIn: anApplicationEnvironment [
	^ self createNewSystem: self basicSystemClass in: anApplicationEnvironment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> createNewPrototypeSystemIn: anApplicationEnvironment [
	^ self createNewSystem: self prototypeSystemClass in: anApplicationEnvironment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> createNewSystem: aSystemClass in: anApplicationEnvironment [
	| currentNumberOfSystems currentNumberOfUnitsOfWork newSystem |
	currentNumberOfSystems := anApplicationEnvironment systemsManager numberOfSystems.
	currentNumberOfUnitsOfWork := anApplicationEnvironment unitsOfWorkManager numberOfUnitsOfWork.
	newSystem := anApplicationEnvironment createCurrentSystemFor: aSystemClass.
	self 
		assert: anApplicationEnvironment systemsManager numberOfSystems 
		equals: currentNumberOfSystems + 1.
	self
		assert: anApplicationEnvironment currentSystem class
		identicalTo: aSystemClass.
	self
		assert: anApplicationEnvironment unitsOfWorkManager numberOfUnitsOfWork
		equals: currentNumberOfUnitsOfWork + 1.
	self
		assert: anApplicationEnvironment currentUnitOfWork class
		identicalTo: LcsUnitOfWork.
	self assert: LcsApplicationEnvironment hasCurrentSystem.
	self assert: LcsApplicationEnvironment hasCurrentUnitOfWork.
	self assert: newSystem isInActiveStatus.
	anApplicationEnvironment systemsManager systems do: [ :eachSystem |
		eachSystem = newSystem 
			ifTrue: [ eachSystem isInActiveStatus ] 
			ifFalse: [ eachSystem isInSuspendedStatus ] ].
	^ anApplicationEnvironment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> newApplicationEnvironmentWithNoSystems [
	<gtExample>
	| environment |
	self suspendedCurrentApplicationEnvironment.
	environment := LcsApplicationEnvironment initializeApplicationEnvironment.
	self validationInitializedApplicationEnvironment.
	^ environment 
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> newUnitOfWork [
	<gtExample>
	| unitOfWork |
	self newApplicationEnvironmentWithNoSystems.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.
	unitOfWork := LcsApplicationEnvironment createUnitOfWork.
	self assert: unitOfWork class identicalTo: LcsUnitOfWork.
	^ unitOfWork
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> noInitializedEnvironmentError [
	<gtExample>
	<noTest>
	self uninitializedApplicationEnvironment.
	self 
		should: [ LcsApplicationEnvironment verifyApplicationEnvironment ] 
		raise: LcsApplicationEnivronmentNotInitializedError.
	LcsApplicationEnvironment verifyApplicationEnvironment 
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> removeCurrentSystem [
	<gtExample>
	| environment |
	environment := self applicationEnvironmentWithCurrentPrototypeSystem.
	environment removeCurrentSystem.
	self assert: environment currentSystem isNil.
	self assert: environment currentUnitOfWork isNil.
	self assert: environment systemsManager systems isEmpty.
	^ environment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> removeCurrentUnitOfWork [
	<gtExample>
	| environment |
	environment := self newApplicationEnvironmentWithNoSystems.
	self deny: environment unitsOfWorkManager hasCurrentUnitOfWork.
	environment unitsOfWorkManager createUnitOfWorkForCurrentSystem.
	self assert: environment unitsOfWorkManager hasCurrentUnitOfWork.
	environment unitsOfWorkManager removeCurrentUnitOfWork.
	self deny: environment unitsOfWorkManager hasCurrentUnitOfWork.
	^ environment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> removingFromChangedCollections [
	<gtExample>
	| unitOfWork |
	self newApplicationEnvironmentWithNoSystems.
	unitOfWork := LcsUnitOfWorkExamples new newUnitOfWork.
	unitOfWork addPendingDeletionOf: 'aaaa' from: 'bbb'.
	self assert: (unitOfWork changedCollections keys includes: 'bbb').
	self assert: (unitOfWork _pendingDeletesIn: 'bbb') class equals: OrderedCollection.
	self assert: ((unitOfWork _pendingDeletesIn: 'bbb') includes: 'aaaa').
	
	self assert: unitOfWork changedCollections notEmpty.
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'add') isEmpty).
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'delete') includes: 'aaaa').
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	^ unitOfWork
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> slotModelNotInitializedError [
	<gtExample>
	<noTest>
	self uninitializedApplicationEnvironment.
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self 
		should: [ LcsDomainObject new ] 
		raise: LcsSlotModelNotInitializedError.
	self
		should: [ LxxPrototypeSystem verifySlotModelInitialized ]
		raise: LcsSlotModelNotInitializedError.
	^ self prototypeSystemClass verifySlotModelInitialized
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> twoSystemsThatWereSwappedAndThenSwappedBackToOriginalState [
	<gtExample>
	| environment basicSystem prototypeSystem |
	environment := self applicationEnvironmentWithCurrentBasicSystemAndSuspendedPrototypeSystem.
	basicSystem := environment currentSystem.
	prototypeSystem := environment systemsManager suspendedSystemFor: self prototypeSystemClass. 
	self assert: prototypeSystem ~~ basicSystem.
	self assert: prototypeSystem isInSuspendedStatus.
	self assert: basicSystem isInActiveStatus.
	
	environment makeSystemCurrent: prototypeSystem.
	self assert: prototypeSystem isInActiveStatus.
	self assert: basicSystem isInSuspendedStatus.

	environment makeSystemCurrent: basicSystem.
	self assert: prototypeSystem isInSuspendedStatus.
	self assert: basicSystem isInActiveStatus.
	^ environment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> uninitializedApplicationEnvironment [
	<gtExample>
	self suspendedCurrentApplicationEnvironment.
	^ LcsApplicationEnvironment
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> unitsOfWorkManagerWithUnitsAddedAndRemoved [
	<gtExample>
	| unitsOfWorkManager unitOfWork environment |
	environment := self newApplicationEnvironmentWithNoSystems.
	unitsOfWorkManager := LcsApplicationEnvironment unitsOfWorkManager.
	self assert: unitsOfWorkManager numberOfUnitsOfWork equals: 0.
	unitOfWork := unitsOfWorkManager createUnitOfWorkForCurrentSystem.
	self assert: unitsOfWorkManager currentUnitOfWork identicalTo: unitOfWork.
	self assert: unitsOfWorkManager numberOfUnitsOfWork equals: 1.
	unitsOfWorkManager removeCurrentUnitOfWork.
	self assert: unitsOfWorkManager currentUnitOfWork identicalTo:nil.
	self assert: unitsOfWorkManager unitsOfWork hasNoElements.
	^ unitsOfWorkManager
]
