Class {
	#name : #LcsCompositeSlotTest,
	#superclass : #LcsPrototypeSystemTest,
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #setUp }
LcsCompositeSlotTest >> domainModelTestClasses [
	^ super domainModelTestClasses
		add: LxxExampleDomain;
		add: LxxExampleComponent;
		yourself
]

{ #category : #tests }
LcsCompositeSlotTest >> testInitializeOfCompositeSlotInNewDomainObject [
	| object |
	object := LxxExampleDomain new.
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: object).
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: object composite).	
	self assert: (object composite isKindOf: LxxExampleComponent).
	self assert: object composite parent == object.
	self assert: (object getPersistedValueOf: 'composite') = object composite.

	self currentSystem currentUnitOfWork applyChanges.
	
	self deny: (self currentSystem unitOfWork hasAddedRecordFor: object).
	self deny: (self currentSystem unitOfWork hasAddedRecordFor: object composite).	

]

{ #category : #tests }
LcsCompositeSlotTest >> testReplacementOfCompositeSlotInNewDomainObject [
	| object originalComponent newComponent|
	object := LxxExampleDomain new.
	originalComponent := object composite.

	object composite: LxxExampleComponent new.
	newComponent := object composite.
	
	self deny: originalComponent == newComponent.
	"self assert: originalComponent parent isNil."
	self assert: newComponent parent == object.
	
	self assert: (self currentSystem unitOfWork hasRemovalRecordFor: originalComponent).
	
]

{ #category : #tests }
LcsCompositeSlotTest >> testReplacementOfCompositeSlotInNewDomainObjectWithInvalidType [
	| object originalComponent newComponent|
	object := LxxExampleDomain new.
	originalComponent := object composite.

	newComponent := LcsDomainObject new.
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: originalComponent).
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: newComponent).
	
	self should: [object composite: newComponent] raise: LcsInvalidSlotType.
	
	self assert: object composite == originalComponent.
	self assert: (self currentSystem unitOfWork hasAddedRecordFor: originalComponent).
	self deny: (self currentSystem unitOfWork hasAddedRecordFor: newComponent).
	self assert: originalComponent parent == object.
	self assert: newComponent parent isNil.
	
	self deny: (self currentSystem unitOfWork hasRemovalRecordFor: originalComponent).
	
]
