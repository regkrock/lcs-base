Class {
	#name : 'LcsUnitOfWorkWithoutSystemTest',
	#superclass : 'LcsTestWithNoApplicationEnvironmentTest',
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'examples' }
LcsUnitOfWorkWithoutSystemTest >> emptyUnitOfWork [
	<gtExample>
	| unitOfWork |
	unitOfWork := LcsUnitOfWork new.
	self assert: unitOfWork system isNil.
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	self assert: unitOfWork changedObjects isEmpty.
	self assert: unitOfWork changedCollections isEmpty.

	self assert: (unitOfWork pendingAddsIn: 'bbb') isEmpty.
	self assert: (unitOfWork pendingDeletesIn: 'bbb') isEmpty.

	self assert: unitOfWork changedCollections isEmpty.
	^ unitOfWork
]

{ #category : 'tests' }
LcsUnitOfWorkWithoutSystemTest >> testAddingToChangedCollections [
	| unitOfWork |
	unitOfWork := self emptyUnitOfWork.
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

{ #category : 'tests' }
LcsUnitOfWorkWithoutSystemTest >> testCreation [
	self emptyUnitOfWork
]

{ #category : 'tests' }
LcsUnitOfWorkWithoutSystemTest >> testRemovingFromChangedCollections [
	| unitOfWork |
	unitOfWork := self emptyUnitOfWork.
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
