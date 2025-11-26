Class {
	#name : 'LcsStringSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsStringSlotBuilderTest >> testCreation [
	self assert: LcsStringSlotBuilder slotClass equals: LcsStringSlot
]

{ #category : 'tests' }
LcsStringSlotBuilderTest >> testSlotDefinitionSource [
]
