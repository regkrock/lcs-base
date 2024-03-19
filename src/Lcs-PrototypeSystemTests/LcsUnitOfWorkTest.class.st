Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LcsUnitOfWorkTest >> testAddDomainObject [
	| domainObject |
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := LcsDomainObject new.
	self assert: self currentSystem currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: self currentSystem currentUnitOfWork addedObjects any domainObject identicalTo: domainObject
	
]

{ #category : #test }
LcsUnitOfWorkTest >> testChangedSlotInDomainObject [
	| domainObject |
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	domainObject := LxxBarebonesPerson new dateOfBirth: Date today.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: domainObject dateOfBirth equals: Date today.
	self assert: ((self currentSystem persons) includes: domainObject).
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

	domainObject dateOfBirth: Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects size equals: 1.
	self assert: (self currentSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: self currentSystem currentUnitOfWork changedObjects any domainObject identicalTo: domainObject.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth = Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

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

{ #category : #test }
LcsUnitOfWorkTest >> testDeleteDomainObject [
	| domainObject |
	domainObject := LcsDomainObject new.
	LcsSystemManager createNewPrototypeSystem. 
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject delete.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects size = 1.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork deletedObjects any isKindOf: LcsDeletedObjectRecord).
	self assert: self currentSystem currentUnitOfWork deletedObjects any domainObject == domainObject
]

{ #category : #test }
LcsUnitOfWorkTest >> testNewUnitOfWorkInSystem [
	LcsSystemManager currentSystem: LxxBarebonesSystem newSystem.
	self assert: (self currentSystem currentUnitOfWork system == self  currentSystem)
]
