Class {
	#name : #LuiLabelWithInputComponent,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> hasInputComponent [
	^ (self componentNamed: 'input') notNil
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> hasLabelComponent [
	^ (self componentNamed: 'label') notNil
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> initialize [
	super initialize.
	self addComponent: (LuiModelLabel named: 'label' on: self)
]

{ #category : #initialize }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition on: aComponent [
	super initializeOnSlot: aSlotDefinition on: aComponent.
	self labelComponent initializeOnSlot: aSlotDefinition on: aComponent.
	self addComponent: (
		(aSlotDefinition inputComponentClass named: 'input' on: self)
			initializeOnSlot: aSlotDefinition on: aComponent;
			yourself)
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> inputComponent [
	^ self componentNamed: 'input'
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> labelComponent [
	^ self componentNamed: 'label'
]

{ #category : #'as yet unclassified' }
LuiLabelWithInputComponent >> model: aModel [
	super model: aModel.
	self valueAccessor model: aModel.
	self hasLabelComponent ifTrue: [
		self labelComponent model: aModel ].
	self hasInputComponent ifTrue: [
		self inputComponent model: aModel ]
]

{ #category : #rendering }
LuiLabelWithInputComponent >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]
