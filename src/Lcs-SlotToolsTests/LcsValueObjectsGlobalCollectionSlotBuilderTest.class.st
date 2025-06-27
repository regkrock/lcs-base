Class {
	#name : #LcsValueObjectsGlobalCollectionSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsValueObjectsGlobalCollectionSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	
	self assert: LcsValueObjectsGlobalCollectionSlotBuilder slotClass equals: LcsValueObjectsGlobalCollectionSlot.
	
	self subject: LcsValueObjectsGlobalCollectionSlotBuilder new.
	self assert: self subject slotDefinitionClassName  equals: 'LcsValueObjectsGlobalCollectionSlot'.
	self assert: self subject collectionClass equals: IdentitySet.
	self assert: self subject parent isNil.
	self assert: self subject jobSteps hasNoJobSteps.
	self assert: self subject collectionElementTypes isEmpty.
	self assert: self subject loaderClassName isNil.
	self assert: self subject refactorings isEmpty.
	self assert: self subject slotClass isNil.
	self assert: self subject slotDefinitionSelector isNil.
	self assert: self subject slotTypeClassName isNil.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject state = 'Initial'.
	self assert: self subject targetClass isNil.
	self assert: self subject targetClassName isNil.
	self assert: self subject targetModule isNil.
	self assert: self subject targetModuleClass isNil.
	self assert: self subject targetModuleName isNil.
]

{ #category : #tests }
LcsValueObjectsGlobalCollectionSlotBuilderTest >> testSlotName [
	self subject: LcsValueObjectsGlobalCollectionSlotBuilder new.
	
	self subject slotName: 'foo'.
	
	self assert: self subject slotName = 'foo'.
	self assert: self subject slotDefinitionSelector equals: 'fooSlotDefinition'.
	
	self subject slotName: 'Foo'.
	self assert: self subject slotName equals: 'foo'.
	self assert: self subject slotDefinitionSelector = 'fooSlotDefinition'.
	
	self subject slotName: 'FooBar'.
	self assert: self subject slotName = 'fooBar'.
	self assert: self subject slotDefinitionSelector equals: 'fooBarSlotDefinition'.
]

{ #category : #tests }
LcsValueObjectsGlobalCollectionSlotBuilderTest >> testTargetClassName [
	self subject: LcsValueObjectsGlobalCollectionSlotBuilder new.
	
	self subject targetClassName: 'FooBar'.
	
	self assert: self subject targetClassName equals:'FooBar'.
	self assert: self subject targetClass isNil.
	
]
