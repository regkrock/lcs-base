Class {
	#name : 'LcsApplicationEnvironmentExamples',
	#superclass : 'LcsExamples',
	#traits : 'LtApplicationEnvironmntExamplesManagement',
	#classTraits : 'LtApplicationEnvironmntExamplesManagement classTrait',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _addToUnitOfWorkCollections [
	| unitOfWork |
	unitOfWork := LcsUnitOfWorkExamples new newUnitOfWork.
	unitOfWork addPendingAddOf: 'aaaa' to: 'bbb'.
	self assert: (unitOfWork changedCollections keys includes: 'bbb').
	self assert: (unitOfWork _pendingAddsIn: 'bbb') class equals: OrderedCollection.
	self assert: ((unitOfWork pendingAddsIn: 'bbb') includes: 'aaaa').
	
	self assert: unitOfWork changedCollections notEmpty.
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'add') includes: 'aaaa').
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'delete') isEmpty).
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _createInstanceOfDomainObject [
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ LcsDomainObject new ] raise: LcsSlotModelNotInitializedError.
	self should: [ LxxPrototypeSystem verifySlotModelInitialized ] raise: LcsSlotModelNotInitializedError
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _newApplicationEnvironment [
	self assert: LcsApplicationEnvironment isStopped.
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self validationInitializedApplicationEnvironment
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _removeCurrentSystem [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	LcsApplicationEnvironment currentSystem: 'example'.
	self assert: LcsApplicationEnvironment currentSystem equals: 'example'.
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _removeCurrentUnitOfWork [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self deny: LcsApplicationEnvironment unitsOfWorkManager hasCurrentUnitOfWork.
	
	LcsApplicationEnvironment unitsOfWorkManager createUnitOfWorkForCurrentSystem.
	self assert: LcsApplicationEnvironment unitsOfWorkManager hasCurrentUnitOfWork.
	
	LcsApplicationEnvironment unitsOfWorkManager removeCurrentUnitOfWork.
	self deny: LcsApplicationEnvironment unitsOfWorkManager hasCurrentUnitOfWork
]

{ #category : 'private' }
LcsApplicationEnvironmentExamples >> _removingFromChangedCollections [
	| unitOfWork |
	unitOfWork := LcsUnitOfWorkExamples new newUnitOfWork.
	unitOfWork addPendingDeletionOf: 'aaaa' from: 'bbb'.
	self assert: (unitOfWork changedCollections keys includes: 'bbb').
	self assert: (unitOfWork _pendingDeletesIn: 'bbb') class equals: OrderedCollection.
	self assert: ((unitOfWork _pendingDeletesIn: 'bbb') includes: 'aaaa').
	
	self assert: unitOfWork changedCollections notEmpty.
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'add') isEmpty).
	self assert: (((unitOfWork changedCollections at: 'bbb') at: 'delete') includes: 'aaaa').
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> createNewApplicationEnvironment [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _newApplicationEnvironment ]
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> createUnitOfWorkOnNilSystem [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _createUnitOfWorkOnNilSystem ]
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> removeCurrentSystem [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _removeCurrentSystem ]
]

{ #category : 'examples' }
LcsApplicationEnvironmentExamples >> removeCurrentUnitOfWork [
	<gtExample>
	^ self inNewEnvironmentDo: [ self _removeCurrentUnitOfWork ]
]
