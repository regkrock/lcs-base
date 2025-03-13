Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #setUp }
LcsUnitOfWorkTest >> setupSunitSystem [
	LxxPrototypeSystem new
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

{ #category : #'as yet unclassified' }
LcsUnitOfWorkTest >> testDeleteDomainObject [
	"| domainObject |
	LxxPrototypeSystem new. 
	domainObject := LcsDomainObject new.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork changedObjects isEmpty.
	LcsApplicationEnvironment currentUnitOfWork applyChanges.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects notEmpty.
	
	domainObject delete.
	self assert: LcsApplicationEnvironment currentUnitOfWork addedObjects isEmpty.
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects size = 1.
	self assert: LcsApplicationEnvironment currentUnitOfWork changedObjects isEmpty.
	self assert: (LcsApplicationEnvironment currentUnitOfWork deletedObjects any isKindOf: LcsDeletedObjectRecord).
	self assert: LcsApplicationEnvironment currentUnitOfWork deletedObjects any domainObject == domainObject"
]

{ #category : #'as yet unclassified' }
LcsUnitOfWorkTest >> testHistoryCreationWithNewDomainObject [
	| domainObject |
		
	domainObject := LcsDomainObject new.

	"Set parent to a 'nonsensical' value so changes can be applied. This is a hack for this test"
	domainObject instVarNamed: 'parent' put: self currentSystem.
	
	self currentSystem applyChanges.
	self assert: domainObject creationDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject creationDate equals: Date today.
	self assert: domainObject creationTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject lastUpdatedDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject lastUpdatedTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject creator equals: self currentSystem currentUser.
	self assert: domainObject history userUuid isInteger
]

{ #category : #tests }
LcsUnitOfWorkTest >> testLastUpdatedDate [
	| person creationTimestamp |
	person := LxxPrototypePerson new.
	
	self currentSystem applyChanges.
	
	creationTimestamp := person creationTimestamp.
	Delay forMilliseconds: 100.
	person dateOfBirth: Date yesterday.
	
	self currentSystem applyChanges.
	
	self assert: person lastUpdatedTimestamp > creationTimestamp.
	self assert: person lastUpdatedUser equals: self currentSystem currentUser
]
