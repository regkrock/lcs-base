Class {
	#name : 'LcsAccessorSlotBuilderExamples',
	#superclass : 'LcsCodeBuilderStepTest',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> allowNilDescription [
	<gtExample>
	| builder magritteDescription |
	builder := self newBuilder.
	magritteDescription := builder allowNilDescription.
	self assert: (magritteDescription read: builder) = false.
	magritteDescription write: true to: builder.
	self assert: (magritteDescription read: builder) = true.
	builder isNilAllowed.
	^ magritteDescription
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> builderWIthValidationConditionRemovedViaDescription [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder addValidationCondition: [ :value | ] description: 'Test'.
	self assert: builder validationConditions collection size equals: 1.
	builder removeValidationConditionWithDescription: 'Test'.
	self assert: builder validationConditions hasNoElements.
	^ builder
]

{ #category : 'tests' }
LcsAccessorSlotBuilderExamples >> builderWithInitalValueSetToNil [
	<gtExample>
	| builder |
	builder :=  LcsAccessorSlotBuilder new.
	self assert: builder initialValueBlock printString equals: '[ ]'.
	builder populateFrom: LcsScaledDecimalSlot name.
	self assert: builder initialValueBlock printString equals: '[ :parentDomainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]'.
	builder initialValueBlockDescription write: 'nil' to: builder.
	self assert: builder initialValueBlock printString equals: '[ :parentDomainObject :slot | nil ]'.
	self assert: (builder initialValueBlock cull: self cull: self) isNil.
	^ builder
]

{ #category : 'tests' }
LcsAccessorSlotBuilderExamples >> builderWithInitialValueBlockUpdatedViaMagritteDescription [
	<gtExample>
	| builder magritteDescription |
	builder := self newBuilder.
	self assert: builder initialValueBlock asString equals: '[ ]'.
	
	magritteDescription := builder initialValueBlockDescription.
	self assert: (magritteDescription read: builder) = ''.
			
	magritteDescription write: '0' to: builder.
	self assert: (magritteDescription read: builder) equals: '0'.

	self assert: builder initialValueBlock asString equals: '[ :parentDomainObject :slot | 0 ]'.
	^ builder
]

{ #category : 'tests' }
LcsAccessorSlotBuilderExamples >> builderWithNilAllowed [
	<gtExample>
	| builder |
	builder := self newBuilder.
	self assert: builder allowNil == false.
	self deny: builder isNilAllowed.
	builder beAllowNil.
	self assert: builder allowNil == true.
	self assert: builder isNilAllowed.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> builderWithPrevalidationTransformBlockChangedViaMagritteDescription [
	<gtExample>
	| magritteDescription builder |
	builder := self newBuilder.
	self assert: builder prevalidationTransformBlock asString equals: '[  ]'.
	
	magritteDescription := builder prevalidationTransformBlockDescription.
	self assert: (magritteDescription read: builder) equals: ''.
			
	magritteDescription write: '0' to: builder.
	self assert: (magritteDescription read: builder) equals: '0'.

	self assert: builder prevalidationTransformBlock asString equals: '[ :value :slot | 0 ]'.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> builderWithSlotTypesAddViMagriteeDescription [
	<gtExample>
	| magritteDescription builder |
	builder := self newBuilder.
	builder slotTypes: { String }.
	magritteDescription := builder slotTypesDescription.
	self assert: (magritteDescription read: builder) equals: #(#String).
	magritteDescription write: #(#String #Integer) to: builder.
	self assert: builder slotTypes equals: { String. Integer}.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> builderWithValidationCondition [
	<gtExample>
	| validationCondition builder |
	validationCondition := LcsValidationCondition new
							validationDescription: 'Test';
							conditionBlock: [ :value | ];
							yourself.
	builder := self newBuilder.
	builder addValidationCondition: validationCondition.
	self assert: builder validationConditions collectionSize equals: 1.
	self assert: builder validationConditions collection any parent identicalTo: builder validationConditions.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> builderWithValidationConditionAddedAndThenRemoved [
	<gtExample>
	| builder validationCondition |
	validationCondition := LcsValidationCondition new
							validationDescription: 'Test';
							conditionBlock: [ :value | ];
							yourself.

	builder := self newBuilder.
	builder addValidationCondition: validationCondition.
	self assert: builder validationConditions collection size equals: 1.
	builder removeValidationCondition: validationCondition.
	self assert: builder validationConditions hasNoElements.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsAccessorSlotBuilder new.
	self assert: builder validationConditions hasNoElements.
	self assert: builder slotTypes isEmpty.
	self assert: builder slotClassName asClass equals: LcsAccessorSlotBuilder slotClass.
	self assert: builder jobSteps hasNoJobSteps.
	self assert: builder refactorings isEmpty.
	self assert: builder state equals: 'Initial'.
	self assert: builder validationConditions class == LcsValidationConditions.
	self assert: builder validationConditions hasNoElements.	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> slotDefinitionAccessorMethods [
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
LcsAccessorSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
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
LcsAccessorSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| slotInstanceBuilder |
	slotInstanceBuilder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: slotInstanceBuilder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ slotInstanceBuilder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ slotDefinitionBuilder
]

{ #category : 'examples' }
LcsAccessorSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionMethodBuilder.
	self assert: slotDefinitionBuilder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsAccessorSlot new
			slotName: ''foo'';
			yourself'.
	^ slotDefinitionBuilder refactoringText
]

{ #category : 'tests' }
LcsAccessorSlotBuilderExamples >> testInstallingSlot [
	self subject: (
		LcsAccessorSlotBuilder new
			slotClassName: LcsStringSlot name;
			targetClassName: LxxPrototypeSystem name;
			addSlotType: LxxPerson name ;
			slotName: 'foos';
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel
]
