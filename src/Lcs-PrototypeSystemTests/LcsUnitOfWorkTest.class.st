Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-PrototypeSystemTests'
}

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
	LcsSystemManager createPrototypeSystem. 
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
