Class {
	#name : #LcsAccessorSlotCreationFormTest,
	#superclass : #LcsCodeBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsAccessorSlotCreationFormTest >> testAddingStringSlot [
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
		self assert: (builderProperties at: eachKey) value equals: (templateProperties at: eachKey) value].
	slotModelBuilder slotName: 'foo'.
	self subject commit
]

{ #category : #'as yet unclassified' }
LcsAccessorSlotCreationFormTest >> testCreation [

	self subject: LcsAccessorSlotCreationForm new.
	self assert: self subject targetClass isNil.
	self assert: self subject slotModelBuilder isNil.
	self assert: self subject slotClass isString..
	self assert: self subject slotClass isEmpty.
	self assert: self subject mode isNil.
	self subject targetClass: LxxPerson.
	self assert: subject targetClass equals: LxxPerson
]
