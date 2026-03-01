Class {
	#name : 'LcsIntegerSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsIntegerSlotBuilder new.
	self assert: builder slotClassName identicalTo: #LcsIntegerSlot.
	self assert: (builder slotTypes includes: Integer).
	self assert: builder slotTypes size = 1.
	^ builder
]

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
	<gtExample>
	| builder |
	builder := self newBuilder
					targetClassName: #LcsDomainObject;
					slotName: 'foo';
					yourself.
	builder buildJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: builder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ builder
]

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ builder
]

{ #category : 'tests' }
LcsIntegerSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| builder |
	builder := self slotDefinitionMethodBuilder.
	self assert: builder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsIntegerSlot new
			slotName: ''foo'';
			yourself'.
	^ builder refactoringText
]

{ #category : 'examples' }
LcsIntegerSlotBuilderExamples >> slotDefinitionMethodSourceWithModifiedInitialValueBlock [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName.
	builder initialValueBlock: [ 1 ].
	self assert: (builder jobStep: 2) refactoringText equals:'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsIntegerSlot new
			slotName: ''foo'';
			initialValueBlock: [ 1 ];
			yourself'
]
