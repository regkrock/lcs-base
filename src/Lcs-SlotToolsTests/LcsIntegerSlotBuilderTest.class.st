Class {
	#name : 'LcsIntegerSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsIntegerSlotBuilderTest >> testCreation [
	self assert: LcsIntegerSlotBuilder slotClass equals: LcsIntegerSlot
]

{ #category : 'tests' }
LcsIntegerSlotBuilderTest >> testInitialValue [
	self subject: (
		LcsIntegerSlotBuilder new
			slotName: 'foo';
			initialValueBlock: [ 1 ];
			yourself).
	self subject buildJobSteps.
		self assert: (self subject jobStep: 2) slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsIntegerSlot new
			slotName: ''foo'';
			initialValueBlock: [ 1 ];
			yourself'
]

{ #category : 'tests' }
LcsIntegerSlotBuilderTest >> testSlotDefinitionSourceCode [
	self subject: (
		LcsIntegerSlotBuilder new
			slotName: 'foo';
			initialValueBlock: [ 1 ];
			yourself).
	self subject buildJobSteps.
		self assert: (self subject jobStep: 2) slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsIntegerSlot new
			slotName: ''foo'';
			initialValueBlock: [ 1 ];
			yourself'
]
