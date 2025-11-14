Class {
	#name : #LcsGlobalCollectionReferenceSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsGlobalCollectionReferenceSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsGlobalCollectionReferenceSlotBuilder slotClass equals: LcsGlobalCollectionReferenceSlot
]

{ #category : #tests }
LcsGlobalCollectionReferenceSlotBuilderTest >> testDefinitionSourceCode [

	self subject: (LcsGlobalCollectionReferenceSlotBuilder new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself).
	self subject buildJobSteps.
		
	self assert: self subject slotName = 'parent'.
	self assert: self subject collectionSlotModuleName equals: LxxPrototypeSystem defaultModuleName.
	self assert: (self subject slotTypes includes: 'LxxPersons').
	self assert: self subject collectionSlotName equals: 'persons'.
	
	self assert: (self subject jobStep: 2) slotDefinitionSource equals: 
'parentSlotDefinition
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			addSlotType: LxxPersons;
			slotName: ''parent'';
			collectionSlotModuleName: ''Prototype System'';
			collectionSlotName: ''persons'';
			yourself'
]
