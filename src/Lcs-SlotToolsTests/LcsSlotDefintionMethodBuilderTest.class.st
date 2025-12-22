Class {
	#name : 'LcsSlotDefintionMethodBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testAddingDuplicateToSlotTypes [
	self subject: LcsSlotDefintionMethodBuilder new.
	self subject slotClass: LcsStringSlot.
	self subject addSlotType: 'String'.
	self assert: self subject slotTypes size = 1.
	self assert: self subject slotTypes first = 'String'.
	
	self subject addSlotType: 'String'.
	self assert: self subject slotTypes size = 1.
	self assert: self subject slotTypes last = 'String'.
	

]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testAddingSlotTypes [
	self subject: LcsSlotDefintionMethodBuilder new.
	self assert: self subject pragmaSelector = 'slotDefinition'.
	
	self subject slotClass: LcsStringSlot.
	self assert: self subject slotTypes isEmpty.
	
	self subject addSlotType: 'String'.
	self assert: self subject slotTypes size = 1.
	self assert: self subject slotTypes first = 'String'.
	
	self subject addSlotType: 'Number'.
	self assert: self subject slotTypes size = 2.
	self assert: self subject slotTypes last = 'Number'.
	
	self subject addSlotType: Object.
	self assert: (self subject slotTypes includes: 'Object')
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testChangingTargetClassName [
	self subject: LcsSlotDefintionMethodBuilder new.
	self subject slotClass: LcsStringSlot.
	self assert: self subject targetClassName isNil.
	
	self subject targetClassName: #Object.
	self assert: self subject targetClassName = #Object.
	self assert: self subject targetClass == Object.
	
	self subject targetClassName: nil.
	self assert: self subject targetClassName isNil.
	self assert: self subject targetClass isNil
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testCreation [
	self subject: LcsSlotDefintionMethodBuilder new.
	self assert: self subject properties class = OrderedDictionary.
	self assert: self subject slotTypes class = OrderedCollection.
	self assert: self subject validationConditions class = LcsValidationConditions.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject allowNil == false.
	self assert: self subject required == false.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotName isNil.
	self assert: self subject targetClass isNil.
	self assert: self subject targetClassName isNil
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testInstallingSlotDefinitionMethod [
	self subject: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			yourself).
	self subject installCode.
	self assert: (LxxBasePerson respondsTo: ('foo' , 'SlotDefinition') asSymbol)
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testSlotDefinitionSourceMethodStringBaseOnLcsCodeSlot [
	| methodSource |
	self subject: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			required: true;
			yourself).
	methodSource := self subject slotDefinitionSource.
	self assert: methodSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
			slotName: ''foo'';
			required: true;
			yourself'
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testSlotDefinitionSourceMethodStringBaseOnLcsStringSlot [
	| methodSource |
	self subject: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			required: true;
			yourself).
	methodSource := self subject slotDefinitionSource.
	self assert: methodSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
			slotName: ''foo'';
			required: true;
			yourself'
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testSlotDefinitionSourceMethodStringWithNoSlotNameDefined [
	self should: [
		(LcsSlotDefintionMethodBuilder new
			slotClass: LcsAccessorSlot;
			targetClassName: #LxxBasePerson;
			required: true;
			yourself) 
				slotDefinitionSource ] raise: LcsError
]

{ #category : 'tests' }
LcsSlotDefintionMethodBuilderTest >> testSlotDefinitionSourceMethodWithValidationConditions [
| methodSource validationCondition |
	self subject: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foo';
			slotClass: LcsStringSlot;
			targetClassName: #LxxBasePerson;
			addValidationCondition: [ false ] description: 'Always fails';
			yourself).
	self assert: self subject validationConditions collectionSize = 1.
	validationCondition := (self subject validationConditions validationConditionWithDescription: 'Always fails').
	self assert: validationCondition conditionBlock printString equals: '[ false ]'.
	self assert: validationCondition validationDescription  equals: 'Always fails'.
	
	methodSource := self subject slotDefinitionSource.
	self assert: methodSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
			slotName: ''foo'';
			addValidationCondition: [ false ] description: ''Always fails'';
			yourself'.
		
	self subject installCode.
	self subject verifyCodeInstallation

]
