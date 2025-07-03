Class {
	#name : #LcsAccessorSlotCreationFormTest,
	#superclass : #LcsCodeBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

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
LcsAccessorSlotCreationFormTest >> testSettingTargetAndTemplateSlot [
	| slotModelBuilder builderProperties templateProperties slotDefinitionMethodBuilder |
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
LcsAccessorSlotCreationFormTest >> testSettingUpStepsToAddFooSlotBasedOnStringSlot [
	| slotModelBuilder slotDefinitionMethodBuilder slotInstanceVariableBuilder |
	self subject: LcsAccessorSlotCreationForm new.
	self subject targetClass: LxxPerson.
	self subject slotClassChangedTo: LcsStringSlot name.
	slotModelBuilder := self subject slotModelBuilder.

	slotModelBuilder slotName: 'foo'.

	slotDefinitionMethodBuilder := slotModelBuilder slotDefinitionMethodBuilder.
	self assert: slotDefinitionMethodBuilder properties size = 1.
	self assert: (slotDefinitionMethodBuilder properties keys includes: 'slotName').
	self assert: (slotDefinitionMethodBuilder properties at: 'slotName') equals: 'foo'.
	self assert: slotDefinitionMethodBuilder slotDefinitionSource equals: 'fooSlotDefinition
	<slotDefinition>
	^ LcsStringSlot new
		slotName: ''foo'';
		yourself'.

	slotInstanceVariableBuilder := slotModelBuilder slotInstanceVariableBuilder.
	self assert: slotInstanceVariableBuilder slotName equals: 'foo'.

	"self subject commit"
]
