Class {
	#name : 'LcsScaledDecimalSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderTest >> testCreation [
	self assert: LcsScaledDecimalSlotBuilder slotClass equals: LcsScaledDecimalSlot
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderTest >> testSlotDefinitionSourceCode [
	self subject: (
		LcsScaledDecimalSlotBuilder new
			slotName: 'foo';
			numberOfDecimals: 4;
			yourself).
	self subject buildJobSteps.
		self assert: (self subject jobStep: 2) slotDefinitionSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsScaledDecimalSlot new
			slotName: ''foo'';
			numberOfDecimals: 4;
			yourself'
]
