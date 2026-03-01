Class {
	#name : 'LcsDateSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDateSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsDateSlotBuilder new.
	self assert: builder slotClassName identicalTo: #LcsDateSlot.
	self assert: (builder slotTypes includes: Date).
	self assert: builder slotTypes size = 1.
	^ builder
]

{ #category : 'examples' }
LcsDateSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsDateSlotBuilderExamples >> slotDefinitionAccessorMethods [
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
LcsDateSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
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
LcsDateSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| slotInstanceBuilder |
	slotInstanceBuilder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: slotInstanceBuilder refactoringText equals: 'LcsDomainObject - add instanceVariable: foo'.
	^ slotInstanceBuilder
]

{ #category : 'examples' }
LcsDateSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ slotDefinitionBuilder
]

{ #category : 'examples' }
LcsDateSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self slotDefinitionMethodBuilder.
	self assert: slotDefinitionBuilder refactoringText equals: 'LcsDomainObject class >>fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsDateSlot new
			slotName: ''foo'';
			yourself'.
	^ slotDefinitionBuilder refactoringText
]

{ #category : 'tests' }
LcsDateSlotBuilderExamples >> testDateChangeValidation [
	| person |
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today addDays: 10];
			addValidationCondition: [ :newDate :parentDomainObject :oldValue |  
				newDate < Date today] description: 'Date must be >= today';
			addValidationCondition: [ :newDate :parentDomainObject :oldValue |  
				newDate > (Date today addDays: 19)] description: 'Date must be < 20 days in the future';
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	person := LxxPerson new.
	self assert: person date equals: (Date today addDays: 10).
	self should: [ person date: (Date today subtractDays: 1) ] raise: LcsSlotValidationError .
	self shouldnt: [ person date: Date today] raise: LcsSlotValidationError .
	self shouldnt: [ person date: (Date today addDays: 19) ] raise: LcsSlotValidationError.
	self should: [ person date: (Date today addDays: 20) ] raise: LcsSlotValidationError
]

{ #category : 'tests' }
LcsDateSlotBuilderExamples >> testInstallingSlot [
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	self assert: (LxxPerson hasAccessorSlotDefinitionNamed: 'date') 
]

{ #category : 'tests' }
LcsDateSlotBuilderExamples >> testInstallingSlotWithInitialValueBlockOverriden [
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today subtractDays: 10 ];
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	self assert: LxxPerson new date equals: (Date today subtractDays: 10)
]

{ #category : 'tests' }
LcsDateSlotBuilderExamples >> testInstallingSlotWithValidationBlocks [
	| slotDefinitionMethodBuilder |
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today addDays: 10 ];
			addValidationCondition: [ :newDate :parentDomainObject :oldValue | newDate < Date today] description: 'Date must be >= today';
			addValidationCondition: [ :newDate :parentDomainObject :oldValue | newDate > (Date today addDays: 19)] description: 'Date must be < 20 days in the future';
			yourself).
	self subject buildJobSteps.
	
	slotDefinitionMethodBuilder := (self subject jobSteps collection at: 2).
	
	self assert: slotDefinitionMethodBuilder  slotDefinitionSource equals: 'dateSlotDefinition
	<accessorSlotDefinition>
	^ LcsDateSlot new
			addValidationCondition: [ :newDate :parentDomainObject :oldValue | newDate < Date today] description: ''Date must be >= today'';
			addValidationCondition: [ :newDate :parentDomainObject :oldValue | newDate > (Date today addDays: 19)] description: ''Date must be < 20 days in the future'';
			slotName: ''date'';
			initialValueBlock: [ Date today addDays: 10 ];
			yourself'
]
