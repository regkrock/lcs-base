Class {
	#name : 'LcsGlobalCollectionReferenceSlotTest',
	#superclass : 'LcsPrototypeSystemRunningTestCase',
	#category : 'Lcs-SlotDefinitionsTests-Tests',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
LcsGlobalCollectionReferenceSlotTest >> testAddingNewDomainObjectToDomainCollection [
	"This is using the definition in #testSlotDefinition. When a person is created, it is added to the 
	 persons collection"
	 
	| domainObject |
	domainObject := LxxPerson new.
	self assert: (self currentSystem persons pendingAdds includes: domainObject).
	self deny: (self currentSystem persons includes: domainObject).
	
	self currentSystem applyChanges.
	self currentSystem currentUnitOfWork hasNoChanges.

	self assert: (self currentSystem persons pendingAdds isEmpty).
	self assert: (self currentSystem persons includes: domainObject).
	self assert: domainObject parent == self currentSystem persons 
]

{ #category : 'tests' }
LcsGlobalCollectionReferenceSlotTest >> testSlotDefinition [
	self subject: (LcsGlobalCollectionReferenceSlot new
						slotName: 'parent';
						collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
						addSlotType: LxxPersons;
						collectionSlotName: 'persons';
						yourself).
	self assert: self subject slotName equals: 'parent'.
	self assert: self subject collectionSlotModuleName equals: LxxPrototypeSystem defaultModuleName.
	self assert: (self subject slotTypes includes: LxxPersons).
	self assert: self subject slotTypes size equals: 1.
	self assert: self subject collectionSlotName equals: 'persons'
]
