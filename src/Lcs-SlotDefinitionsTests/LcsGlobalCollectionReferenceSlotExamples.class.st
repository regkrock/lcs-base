Class {
	#name : 'LcsGlobalCollectionReferenceSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsGlobalCollectionReferenceSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsGlobalCollectionReferenceSlot new.
	^ slot
]

{ #category : 'tests' }
LcsGlobalCollectionReferenceSlotExamples >> personWhoseParentIsThePersonsCollectionSlot [
	<gtExample>
	| slot |
	slot :=  self newSlot
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself.
	self assert: slot slotName equals: 'parent'.
	self
		assert: slot collectionSlotModuleName
		equals: LxxPrototypeSystem defaultModuleName.
	self assert: (slot slotTypes includes: LxxPersons).
	self assert: slot slotTypes size equals: 1.
	self assert: slot collectionSlotName equals: 'persons'.
	^ slot
]
