Class {
	#name : 'LuiLabelWithInputComponent',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition on: nil
]

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition on: aComponent [
	^ super new 
		initializeOnSlot: aSlotDefinition on: aComponent;
		yourself
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> hasInputComponent [
	^ (self componentNamed: 'input') notNil
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> hasLabelComponent [
	^ (self componentNamed: 'label') notNil
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> initialize [
	super initialize.
	self addComponent: (LuiModelLabel named: 'label')
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition on: aComponent [
	self componentName: aSlotDefinition slotName.
	self labelComponent initializeOnSlot: aSlotDefinition on: aComponent.
	self addComponent: (
		(aSlotDefinition inputComponentClass named: 'input')
			initializeOnSlot: aSlotDefinition on: aComponent;
			yourself)
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> inputComponent [
	^ self componentNamed: 'input'
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> labelComponent [
	^ self componentNamed: 'label'
]

{ #category : 'as yet unclassified' }
LuiLabelWithInputComponent >> model: aModel [
	"super model: aModel.
	self valueAccessor model: aModel."
	self hasLabelComponent ifTrue: [
		self labelComponent model: aModel ].
	self hasInputComponent ifTrue: [
		self inputComponent model: aModel ]
]
