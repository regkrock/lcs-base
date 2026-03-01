Class {
	#name : 'LcsBooleanSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
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
	| slotAccessorsBuilder |
	slotAccessorsBuilder := self slotDefinitionAccessorMethodBuilder.
	self assert: slotAccessorsBuilder refactoringText equals: 'foo
	^ self slotVarNamed: ''foo''

foo: anObject
	self slotVarNamed: ''foo'' put: anObject'.	
	^ slotAccessorsBuilder refactoringText
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
	| slotInstanceBuilder |
	slotInstanceBuilder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: slotInstanceBuilder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ slotInstanceBuilder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ slotDefinitionBuilder
]

{ #category : 'examples' }
LcsBooleanSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionMethodBuilder.
	self assert: slotDefinitionBuilder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsBooleanSlot new
			slotName: ''foo'';
			yourself'.
	^ slotDefinitionBuilder refactoringText
]
