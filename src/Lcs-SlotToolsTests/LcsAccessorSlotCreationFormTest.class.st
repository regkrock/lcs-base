Class {
	#name : #LcsAccessorSlotCreationFormTest,
	#superclass : #LcsCodeBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsAccessorSlotCreationFormTest >> slotModelBuilder [
	^ self subject slotModelBuilder
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testCreation [

	self subject: LcsAccessorSlotCreationForm new.
	self assert: self subject targetClass isNil.
	self assert: self subject slotModelBuilder isNil.
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
	self assert: self subject slotModelBuilder isNil.
	self assert: self subject slotClassName isString..
	self assert: self subject slotClassName isEmpty.
	self assert: self subject mode = #edit
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testCreationUsingNewOn [

	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self assert: self subject targetClass equals: LxxPerson.
	self assert: self subject slotModelBuilder isNil.
	self assert: self subject slotClassName isString..
	self assert: self subject slotClassName isEmpty.
	self assert: self subject mode = #add
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testModifyingBlock [
	| aDescription |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: #LcsScaledDecimalSlot.
	self slotModelBuilder isKindOf: LcsScaledDecimalSlot.
	aDescription := self subject initialValueBlockDescription.
	self assert: aDescription notNil.
	"aDescription accessor chainAccessor: #(slotModelBuilder initialValueBlock)."
	self assert: (aDescription read: self subject) asString equals: '0 asScaledDecimal: slotDefinition numberOfDecimals'.
	aDescription write: '0 asScaledDecimal: slot numberOfDecimals' to: self subject.
	self assert: self slotModelBuilder initialValueBlock asString equals: '[ :domainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]'
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
		self assert: (builderProperties at: eachKey) value equals: (templateProperties at: eachKey) value]
]

{ #category : #tests }
LcsAccessorSlotCreationFormTest >> testSlotGenerationFromTemplateWithNoChanges [
	| slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	self subject: (LcsAccessorSlotCreationForm newOn: LxxPerson).
	self subject slotClassChangedTo: LcsCodeSlot name.
	slotDefinitionMethodBuilder := (self slotModelBuilder jobStep: 2).
	
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'codeSlotDefinition
	<slotDefinition>
	^ LcsCodeSlot new
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
