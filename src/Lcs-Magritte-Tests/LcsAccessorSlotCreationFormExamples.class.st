Class {
	#name : 'LcsAccessorSlotCreationFormExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-Magritte-Tests-Examples',
	#package : 'Lcs-Magritte-Tests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> formWithOnlyNecessaryPropertiesAreInitializedInSlotDefinitionMethod [
	<gtExample>
	| form slotDefinitionMethodBuilder |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.
	slotDefinitionMethodBuilder := form slotModelBuilder jobStep: 2.
	self deny: form slotModelBuilder allowNil.

	form slotModelBuilder slotName: 'foo'.
	form slotModelBuilder beDisallowNil.

	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		yourself'.

	"Test that only the neccessry code is generated"
	form slotModelBuilder beAllowNil.
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		beAllowNill;
		yourself'.
	^ form

]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> formWithSlotClassChangedAndSubstepsAreProperlySetup [
	<gtExample>
	| form |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsValueCodeSlot name.
	self
		assert: (form slotModelBuilder jobStep: 2) slotDefinitionSource
		equals: 'codeSlotDefinition
	<accessorSlotDefinition>
	^ LcsValueCodeSlot new'.
	self assert: (form slotModelBuilder jobStep: 1) slotName equals: 'code'
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> formWithTemplateAndBuilderPropertiesCompared [
	<gtExample>
	| form builderProperties templateProperties |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.
	self assert: form slotModelBuilder class equals: LcsStringSlotBuilder.
	self assert: form slotModelBuilder targetClass equals: LxxPerson.
	self assert: form slotModelBuilder targetClassName equals: LxxPerson name .
	builderProperties := form slotModelBuilder properties.
	templateProperties := form slotModelBuilder slotDefinitionTemplate properties.
	self assert: builderProperties size equals: templateProperties size.
	self assert: builderProperties keys asSortedCollection equals: templateProperties keys asSortedCollection.
	builderProperties keys do: [ :eachKey |
		self assertObject: (builderProperties at: eachKey) equals: (templateProperties at: eachKey)].
	^ form
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> formWithVirtualSlotBuilder [
	<gtExample>
	| form |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: #LcsScaledDecimalSlot.
	form slotClassName: 'LcsStringSlot'.
	self assert: form slotBuilderClass equals: LcsStringSlotBuilder.
	form slotClassName: 'LcsAccessorSlot'.
	self assert: form slotBuilderClass equals: LcsAccessorSlotBuilder.
	form slotClassName: 'LcsVirtualSlot'.
	self assert: form slotBuilderClass equals: LcsVirtualSlotBuilder.
	^ form
]

{ #category : 'form' }
LcsAccessorSlotCreationFormExamples >> model [
	^self subjectScripter model
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> modifiedInitialValueBlock [
	<gtExample>
	| form description |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: #LcsScaledDecimalSlot.
	description := form initialValueBlockDescription.
	self
		assert: (description read: form) asString
		equals: '0 asScaledDecimal: slot numberOfDecimals'.
	description write: '0 asScaledDecimal: slot numberOfDecimals' to: form.
	self
		assert: form slotModelBuilder initialValueBlock asString
		equals: '[ :parentDomainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]'.
	^ form slotModelBuilder initialValueBlock
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> modifiedPrevalidationTransformBlock [
	<gtExample>
	| form description |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: #LcsScaledDecimalSlot.
	form slotModelBuilder isKindOf: LcsScaledDecimalSlot.
	description := form prevalidationTransformBlockDescription.
	self assert: description notNil.
	self assert: (description read: form) asString equals: 'value'.
	description write: '0 asScaledDecimal: slot numberOfDecimals' to: form.
	self assert: form slotModelBuilder prevalidationTransformBlock asString equals: '[ :value :slot | 0 asScaledDecimal: slot numberOfDecimals ]'.
	^ form slotModelBuilder prevalidationTransformBlock
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> newForm [
	<gtExample>
	| form |
	form := LcsSlotCreationForm new.
	self assert: form targetClass isNil.
	self assert: form targetClassName isNil.
	self assert: form isSlotModelBuilderNotReified.
	self assert: form slotClassName isString.
	self assert: form slotClassName isEmpty.
	self assert: form mode isNil.
	self assert: (form isSlotClass: 'LcsStringSlot').
	self assert: (form isSlotClass: 'LcsAccessorSlot').
	self assert: (form isSlotClass: 'LcsVirtualSlot').
	^ form
]

{ #category : 'examples' }
LcsAccessorSlotCreationFormExamples >> newFormOnLxxPerson [
	<gtExample>
	| form |
	form := self newForm targetClassNameChangedTo: 'LxxPerson'.
	self assert: form targetClass equals: LxxPerson.
	^ form
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> requiredDescription [
	<gtExample>
	| description form |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.
	description := form requiredDescription.
	self assert: (description read: form) equals: false.
	description write: true to: form.
	self assert: form slotModelBuilder required equals: true..
	^ description
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> slotNameAccessorDelegatedToSlotModelBuilder [
	<gtExample>
	| chainAccessor form |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.
	chainAccessor := form slotNameDescription accessor.
	self assert: chainAccessor accessor readSelector equals: #'slotModelBuilder'.
	self assert: chainAccessor next readSelector equals: #slotName.
	^ chainAccessor
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> slotTypesDescription [
	<gtExample>
	| decription form |
	form := self newFormOnLxxPerson.
	self assert:form slotTypesDescription isNil.
	form slotClassChangedTo: #LcsValueCodeSlot.
	form slotModelBuilder isKindOf: LcsValueCodeSlot.
	decription := form slotTypesDescription.
	self assert: decription notNil.
	self assert: (decription read: form) asString equals: 'an OrderedCollection(#String)'.
	^ decription
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> smalltalkObjectSlotFormWithTwoSlotTypes [
	<gtExample>
	| form|
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsSmalltalkObjectSlot name.
	self assert: (form slotTypesDescription read: form) isEmpty.
	form slotTypesDescription write: #(#String #Integer) to: form.
	self assert: form slotModelBuilder slotTypes equals: { String. Integer}.
	^ form
]

{ #category : 'tests' }
LcsAccessorSlotCreationFormExamples >> strongSlotFormWithFooSlotName [
	<gtExample>
	| form slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.

	form slotModelBuilder slotName: 'foo'.

	slotDefinitionMethodBuilder := form slotModelBuilder jobStep: 2.
	self assert: slotDefinitionMethodBuilder properties size = 2.
	self assert: (slotDefinitionMethodBuilder properties keys includes: 'slotName').
	self assert: (slotDefinitionMethodBuilder properties keys includes: 'postUpdateActions').
	self assert: (slotDefinitionMethodBuilder properties at: 'slotName') equals: 'foo'.
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		yourself'.

	slotInstanceVariableBuilder := form slotModelBuilder jobStep: 1.
	self assert: slotInstanceVariableBuilder slotName equals: 'foo'.
	^ form
]

{ #category : 'examples' }
LcsAccessorSlotCreationFormExamples >> virtualSlotCreationForm [
	<gtExample>
	| form |
	form := self newFormOnLxxPerson.
	form slotClassChangedTo: LcsStringSlot name.
	self assert: form slotClassName equals: 'LcsStringSlot'.
	form slotClassChangedTo: LcsVirtualSlot name.
	self assert: form slotClassName equals: 'LcsVirtualSlot'.
	^ form
]
