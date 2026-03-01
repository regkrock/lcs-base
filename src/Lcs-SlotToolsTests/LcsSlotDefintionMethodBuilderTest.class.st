Class {
	#name : 'LcsSlotDefintionMethodBuilderTest',
	#superclass : 'LcsObjectExamples',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSlotDefintionMethodBuilderTest >> builderWithFourSlotTypes [
	<gtExample>
	| builder |
	builder := self newBuilder.
	self assert: builder slotTypes isEmpty.
	builder addSlotType: 'String'.
	" Duplicates are ignored"
	builder addSlotType: 'String'.
	builder addSlotType: 'Number'.
	builder addSlotType: Object.
	builder addSlotType: 'XXXX'.
	self assert: builder slotTypes size = 4.	
	self assert: (builder slotTypes includes: String).
	self assert: (builder slotTypes includes: Number).
	self assert: (builder slotTypes includes: Object).
	self assert: (builder slotTypes includes: 'XXXX').
	^ builder
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> installedAndRemovedSlotDefinitionMethod [
	<gtExample>
	| builder |
	builder := (
		LcsSlotDefinitionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			yourself).
	[
	  builder installCode.
	  self assert: (LxxBasePerson respondsTo: ('foo' , 'SlotDefinition') asSymbol) ]
		ensure: [
			builder uninstall.
			self deny: (LxxBasePerson respondsTo: ('foo' , 'SlotDefinition') asSymbol) ].
	^ builder
]

{ #category : 'examples' }
LcsSlotDefintionMethodBuilderTest >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSlotDefinitionMethodBuilder new.
	self assert:builder properties class = OrderedDictionary.
	self assert: builder slotTypes class = OrderedCollection.
	self assert: builder validationConditions class = LcsValidationConditions.
	self assert: builder slotTypes isEmpty.
	self assert: builder allowNil == false.
	self assert: builder required == false.
	self assert: builder slotTypes isEmpty.
	self assert: builder slotName isNil.
	self assert: builder targetClass isNil.
	self assert: builder targetClassName isNil.
	self assert: builder pragmaSelector = LcsBaseSlot accessorSlotDefinitionName.
	self verifyChangingTargetClassName: builder.
	^ builder
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> slotDefinitionSourceMethodStringBaseOnLcsStringSlot [
	<gtExample>
	| builder |
	builder := 
		LcsSlotDefinitionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			required: true;
			yourself.
	self assert: builder slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
			slotName: ''foo'';
			required: true;
			yourself'
]

{ #category : 'examples' }
LcsSlotDefintionMethodBuilderTest >> slotDefinitionSourceMethodStringWithNoSlotNameDefined [
	<gtExample>
	| builder |
	builder := LcsSlotDefinitionMethodBuilder new
			slotClass: LcsAccessorSlot;
			targetClassName: #LxxBasePerson;
			required: true;
			yourself.
	self should: [ builder slotDefinitionSource ] raise: LcsError.
	^ builder
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> slotDefinitionSourceMethodWithValidationConditions [
	<gtExample>
	| methodSource validationCondition builder |
	builder := (
		self newBuilder
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			addValidationCondition: [ false ] description: 'Always fails';
			yourself).
	self assert: builder validationConditions collectionSize = 1.
	validationCondition := (builder validationConditions validationConditionWithDescription: 'Always fails').
	self assert: validationCondition conditionBlock printString equals: '[ false ]'.
	self assert: validationCondition validationDescription  equals: 'Always fails'.
	
	methodSource := builder slotDefinitionSource.
	self assert: methodSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
			addValidationCondition: [ false ] description: ''Always fails'';
			slotName: ''foo'';
			yourself'.
		
	^ builder
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> verifyChangingTargetClassName: builder [
	self assert: builder targetClassName isNil.
	self assert: builder targetClass isNil.
	
	builder targetClassName: #Object.
	self assert: builder targetClassName = #Object.
	self assert: builder targetClass == Object.

	builder targetClass: Integer.
	self assert: builder targetClassName = #Integer.
	self assert: builder targetClass == Integer.
	
	builder targetClassName: nil.
	self assert: builder targetClassName isNil.
	self assert: builder targetClass isNil
]
