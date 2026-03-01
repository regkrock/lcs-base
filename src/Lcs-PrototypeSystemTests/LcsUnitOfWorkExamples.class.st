Class {
	#name : 'LcsUnitOfWorkExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUnitOfWorkExamples >> deleteDomainObject [
	"<gtExample>
	| domainObject |
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

{ #category : 'examples' }
LcsUnitOfWorkExamples >> historyObjectOfNewDomainObject [
	<gtExample>
	| domainObject history |
	self ensureCurrentSystemIsPrototypeSystem.
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
	self assert: (history := domainObject history) userUuid isInteger.
	self removeCurrentSystemAndActivateSavedSystem.
	^ history
]

{ #category : 'examples' }
LcsUnitOfWorkExamples >> historyOfAllSlotChanges [
	<gtExample>
	| person slotChangeHistory |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	
	self currentSystem applyChanges.
	"self assert: person history."
	self assert: person history changeRecords collection size equals: 1.
	slotChangeHistory := person historyOfAllSlotChanges.
	self assert: slotChangeHistory size = person allAccessorSlotDefinitions size.
	
	Delay forMilliseconds: 100.
	person dateOfBirth: Date yesterday.

	self currentSystem applyChanges.
	slotChangeHistory := person historyOfAllSlotChanges.
	self assert: slotChangeHistory size equals: person allAccessorSlotDefinitions size + 2.

	
	Delay forMilliseconds: 100.
	person dateOfBirth: (Date yesterday subtractDays: 1).
	
	self currentSystem applyChanges.
	slotChangeHistory := person historyOfAllSlotChanges.
	self assert: slotChangeHistory size equals: person allAccessorSlotDefinitions size + 4.
	^ slotChangeHistory

]

{ #category : 'tests' }
LcsUnitOfWorkExamples >> historyOfSlotChange [
	<gtExample>
	| person slotChangeHistory |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	
	self currentSystem applyChanges.
	"self assert: person history."
	self assert: person history changeRecords collection size equals: 1.
	slotChangeHistory := person historyOfChangesToSlot: 'dateOfBirth'.
	self assert: slotChangeHistory size = 1.
	
	Delay forMilliseconds: 100.
	person dateOfBirth: Date yesterday.

	self currentSystem applyChanges.
	slotChangeHistory := person historyOfChangesToSlot: 'dateOfBirth'.
	self assert: slotChangeHistory size = 2.

	
	Delay forMilliseconds: 100.
	person dateOfBirth: (Date yesterday subtractDays: 1).
	
	self currentSystem applyChanges.
	slotChangeHistory := person historyOfChangesToSlot: 'dateOfBirth'.
	self assert: slotChangeHistory size = 3.
	self removeCurrentSystemAndActivateSavedSystem.
	^ slotChangeHistory
]

{ #category : 'examples' }
LcsUnitOfWorkExamples >> lastUpdatedDate [
	<gtExample>
	| person creationTimestamp |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	
	self currentSystem applyChanges.
	
	creationTimestamp := person creationTimestamp.
	Delay forMilliseconds: 100.
	person dateOfBirth: Date yesterday.
	
	self currentSystem applyChanges.
	
	self assert: person lastUpdatedTimestamp > creationTimestamp.
	self assert: person lastUpdatedUser equals: self currentSystem currentUser.
	self removeCurrentSystemAndActivateSavedSystem.
	^ person lastUpdatedTimestamp
]

{ #category : 'examples' }
LcsUnitOfWorkExamples >> newUnitOfWork [
	<gtExample>
	| unitOfWork |
	unitOfWork := LcsUnitOfWork new.
	self assert: unitOfWork system isNil.
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	self assert: unitOfWork changedObjects isEmpty.
	^ unitOfWork
]
