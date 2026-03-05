Class {
	#name : 'LcsBooleanSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsBooleanSlotBuilder new.
	self assert: builder slotClassName identicalTo: #LcsBooleanSlot.
	self assert: (builder slotTypes includes: Boolean).
	self assert: builder slotTypes size = 1.
	^ builder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionAccessorMethods [
	<gtExample>
	| builder |
	builder := self slotDefinitionAccessorMethodBuilder.
	self assert: builder refactoringText equals: 'foo
	^ self slotVarNamed: ''foo''

foo: anObject
	self slotVarNamed: ''foo'' put: anObject'.	
	^ builder refactoringText
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
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
LcsBooleanSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: builder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ builder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ builder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| builder |
	builder := self slotDefinitionMethodBuilder.
	self assert: builder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsBooleanSlot new
			slotName: ''foo'';
			yourself'.
	^ builder refactoringText
]
