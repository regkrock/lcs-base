Class {
	#name : 'LcsScaledDecimalSlotBuilderExamples',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsScaledDecimalSlotBuilder new.
	self assert: LcsScaledDecimalSlotBuilder slotClass identicalTo: LcsScaledDecimalSlot.
	self assert: (builder slotTypes includes: ScaledDecimal).
	self assert: builder slotTypes size = 1.
	^ builder
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| slotAccessorsBuilder |
	slotAccessorsBuilder := self slotDefinitionBuilderWithSlotNameAndNumberOfDecimalsOverridden jobStep: 3.
	^ slotAccessorsBuilder
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionAccessorMethods [
	<gtExample>
	| slotAccessorsBuilder |
	slotAccessorsBuilder := self slotDefinitionAccessorMethodBuilder.
	self assert: slotAccessorsBuilder refactoringText equals: 'foo
	^ self slotVarNamed: ''foo''

foo: anObject
	self slotVarNamed: ''foo'' put: anObject'.	
	^ slotAccessorsBuilder refactoringText
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionBuilderWithSlotNameAndNumberOfDecimalsOverridden [
	<gtExample>
	| builder |
	builder := self newBuilder
					targetClassName: #LcsDomainObject;
					slotName: 'foo';
					numberOfDecimals: 4;
					yourself.
	builder buildJobSteps.
	^ builder
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| slotInstanceBuilder |
	slotInstanceBuilder := self slotDefinitionBuilderWithSlotNameAndNumberOfDecimalsOverridden jobStep: 1.
	self assert: slotInstanceBuilder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ slotInstanceBuilder
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionBuilderWithSlotNameAndNumberOfDecimalsOverridden jobStep: 2.
	^ slotDefinitionBuilder
]

{ #category : 'tests' }
LcsScaledDecimalSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionMethodBuilder.
	self assert: slotDefinitionBuilder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsScaledDecimalSlot new
			slotName: ''foo'';
			numberOfDecimals: 4;
			yourself'.
	^ slotDefinitionBuilder refactoringText
]
