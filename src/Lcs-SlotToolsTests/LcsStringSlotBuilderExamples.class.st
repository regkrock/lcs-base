Class {
	#name : 'LcsStringSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStringSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsStringSlotBuilder new.
	self assert: builder slotClassName identicalTo: #LcsStringSlot.
	self assert: (builder slotTypes includes: String).
	self assert: builder slotTypes size = 1.
	^ builder
]

{ #category : 'examples' }
LcsStringSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsStringSlotBuilderExamples >> slotDefinitionAccessorMethods [
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
LcsStringSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
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
LcsStringSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: builder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ builder
]

{ #category : 'examples' }
LcsStringSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ builder
]

{ #category : 'examples' }
LcsStringSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| builder |
	builder := self slotDefinitionMethodBuilder.
	self assert: builder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
			slotName: ''foo'';
			yourself'.
	^ builder refactoringText
]
