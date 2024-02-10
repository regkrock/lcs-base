Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #TestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsUnitOfWorkTest >> testAddDomainObject [
	| domainObject |
	LcsSystem createNewSingleton.
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := LcsDomainObject new.
	self assert: LcsSystem currentUnitOfWork addedObjects size = 1.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (LcsSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: LcsSystem currentUnitOfWork addedObjects any domainObject == domainObject
	
]

{ #category : #accessing }
LcsUnitOfWorkTest >> testChangedSlotInDomainObject [
	| domainObject |
	LcsSystem createNewSingleton.
	domainObject := LcsPerson new dateOfBirth: Date today.
	"LcsSystem currentUnitOfWork applyChanges."
	LcsSystem createNewSingleton.
	self assert: domainObject dateOfBirth = Date today.
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	domainObject dateOfBirth: Date yesterday.
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects size = 1.
	self assert: (LcsSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: LcsSystem currentUnitOfWork changedObjects any domainObject == domainObject.
	self assert: domainObject dateOfBirth = Date yesterday
]

{ #category : #test }
LcsUnitOfWorkTest >> testCreation [

	| unitOfWork |

	unitOfWork := LcsUnitOfWork new.
	self assert: unitOfWork system isNil.
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	self assert: unitOfWork changedObjects isEmpty.
]

{ #category : #accessing }
LcsUnitOfWorkTest >> testDeleteDomainObject [
	| domainObject |
	domainObject := LcsDomainObject new.
	LcsSystem createNewSingleton.
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	domainObject delete.
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects size = 1.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (LcsSystem currentUnitOfWork deletedObjects any isKindOf: LcsDeletedObjectRecord).
	self assert: LcsSystem currentUnitOfWork deletedObjects any domainObject == domainObject
]

{ #category : #test }
LcsUnitOfWorkTest >> testNewUnitOfWorkInSystem [
	LcsSystem createNewSingleton.
	self assert: (LcsSystem singleton currentUnitOfWork system == LcsSystem singleton)
]
