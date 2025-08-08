Class {
	#name : #LcsAccessorSlotCreationFormTest,
	#superclass : #LcsCodeBuilderTest,
	#category : #'Lcs-Magritte-Tests-Tests'
}

{ #category : #form }
LcsAccessorSlotCreationFormTest >> model [
	^self subjectScripter model
]

{ #category : #private }
LcsAccessorSlotCreationFormTest >> slotModelBuilder [
	^ self subject slotModelBuilder
]

{ #category : #form }
LcsAccessorSlotCreationFormTest >> stringSlotAccessorSlotCreationForm [
	^ LcsAccessorSlotCreationFormExamples new stringSlotAccessorSlotCreationForm
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testAccessingSlotTypesFromAssociatedSlotBuilder [
	| aDescription |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: #LcsValueCodeSlot.
	self slotModelBuilder isKindOf: LcsValueCodeSlot.
	aDescription := self subject slotTypesDescription.
	self assert: aDescription notNil.
	self assert: (aDescription read: self subject) asString equals: 'an OrderedCollection(#String)'.
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testChainAccessor [
	| chainAccessor |
	self subject: LcsAccessorSlotCreationForm new.
	"chainAccessor := self subject  chainAccessorFor: #('foo')."
	chainAccessor := MAChainAccessor accessors: #(#'slotModelBuilder' #'foo' #'bar').
	self assert: chainAccessor accessor selector equals: #'slotModelBuilder'.
	self assert: chainAccessor next accessor selector equals: #'foo'.
	self assert: chainAccessor next next selector equals: #'bar'
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testCreation [

	self subject: LcsAccessorSlotCreationForm new.
	self assert: self subject targetClass isNil.
	self assert: self subject isSlotModelBuilderNotReified.
	self assert: self subject slotClassName isString..
	self assert: self subject slotClassName isEmpty.
	self assert: self subject mode isNil.
	self subject targetClass: LxxPerson.
	self assert: subject targetClass equals: LxxPerson
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testCreationUsingNewEditOn [

	self subject: (LcsAccessorSlotCreationForm newEditOn: LxxPerson).
	self assert: self subject targetClass equals: LxxPerson.
	self assert: self subject isSlotModelBuilderNotReified.
	self assert: self subject slotClassName isString..
	self assert: self subject slotClassName isEmpty.
	self assert: self subject mode = #edit
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testCreationUsingNewOn [

	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self assert: self subject targetClass equals: LxxPerson.
	self assert: self subject isSlotModelBuilderNotReified.
	self assert: self subject slotClassName isString..
	self assert: self subject slotClassName isEmpty.
	self assert: self subject mode = #add
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testModifyingInitialValueBlock [
	| aDescription |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: #LcsScaledDecimalSlot.
	self slotModelBuilder isKindOf: LcsScaledDecimalSlot.
	aDescription := self subject initialValueBlockDescription.
	self assert: aDescription notNil.
	self assert: (aDescription read: self subject) asString equals: '0 asScaledDecimal: slot numberOfDecimals'.
	aDescription write: '0 asScaledDecimal: slot numberOfDecimals' to: self subject.
	self assert: self slotModelBuilder initialValueBlock asString equals: '[ :domainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]'
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testModifyingPrevalidationTransformBlock [
	| aDescription |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: #LcsScaledDecimalSlot.
	self slotModelBuilder isKindOf: LcsScaledDecimalSlot.
	aDescription := self subject prevalidationTransformBlockDescription.
	self assert: aDescription notNil.
	self assert: (aDescription read: self subject) asString equals: 'value'.
	aDescription write: '0 asScaledDecimal: slot numberOfDecimals' to: self subject.
	self assert: self slotModelBuilder prevalidationTransformBlock asString equals: '[ :value :slot | 0 asScaledDecimal: slot numberOfDecimals ]'
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testRequiredDescription [
	| description |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.
	description := self subject requiredDescription.
	self assert: (description read: self subject) equals: false.
	description write: true to: self subject.
	self assert: self subject slotModelBuilder required equals: true.
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSettingTargetAndTemplateSlot [
	| slotModelBuilder builderProperties templateProperties |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.
	self assert: self subject slotClassName equals: LcsStringSlot name.
	self assert: (slotModelBuilder := self subject slotModelBuilder) class equals: LcsStringSlotBuilder.
	self assert: slotModelBuilder targetClass equals: LxxPerson.
	self assert: slotModelBuilder targetClassName equals: LxxPerson name .
	builderProperties := slotModelBuilder properties.
	templateProperties := slotModelBuilder slotDefinitionTemplate properties.
	self assert: builderProperties size equals: templateProperties size.
	self assert: builderProperties keys asSortedCollection equals: templateProperties keys asSortedCollection.
	builderProperties keys do: [ :eachKey |
		self assertObject: (builderProperties at: eachKey) equals: (templateProperties at: eachKey)]
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSlotGenerationFromTemplateWithNoChanges [
	| slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: LcsValueCodeSlot name.
	slotDefinitionMethodBuilder := (self slotModelBuilder jobStep: 2).
	
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'codeSlotDefinition
	<slotDefinition>
	^ LcsValueCodeSlot new
		yourself'.

	slotInstanceVariableBuilder := (self slotModelBuilder jobStep: 1).
	self assert: slotInstanceVariableBuilder slotName equals: 'code'.
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSlotGenerationWithAllowNilTurnedOnAndThenTurnedOff [
	| slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.
	slotDefinitionMethodBuilder := self slotModelBuilder jobStep: 2.
	self assert: self slotModelBuilder allowNil = true.

	self slotModelBuilder slotName: 'foo'.
	self slotModelBuilder allowNil: false.

	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		allowNil: false;
		yourself'.

	"Test that the unneccessry code is generated"
	self slotModelBuilder allowNil: true.
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		yourself'.


]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSlotGenerationWithOnlySlotNameChanged [
	| slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.

	self slotModelBuilder slotName: 'foo'.

	slotDefinitionMethodBuilder := self slotModelBuilder jobStep: 2.
	self assert: slotDefinitionMethodBuilder properties size = 1.
	self assert: (slotDefinitionMethodBuilder properties keys includes: 'slotName').
	self assert: (slotDefinitionMethodBuilder properties at: 'slotName') equals: 'foo'.
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		yourself'.

	slotInstanceVariableBuilder := self slotModelBuilder jobStep: 1.
	self assert: slotInstanceVariableBuilder slotName equals: 'foo'.
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSlotTypesDescription [
	| description |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.
	description := self subject slotTypesDescription.
	self assert: (description read: self subject) equals: (OrderedCollection with: #String).
	description write: #(#String #Integer) to: self subject.
	self assert: self subject slotModelBuilder slotTypes equals: { String. Integer}.
]
