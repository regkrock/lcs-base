Class {
	#name : 'LuiLabelWithInputComponent',
	#superclass : 'LuiComponent',
	#instVars : [
		'slotName'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiLabelWithInputComponent class >> onSlot: aSlotDefinition [
	^ super new 
		initializeOnSlot: aSlotDefinition;
		yourself
]

{ #category : 'testing' }
LuiLabelWithInputComponent >> hasInputComponent [
	^ (self componentNamed: self slotName) notNil
]

{ #category : 'testing' }
LuiLabelWithInputComponent >> hasLabelComponent [
	^ (self componentNamed: self slotNameLabel) notNil
]

{ #category : 'initialize' }
LuiLabelWithInputComponent >> initializeOnSlot: aSlotDefinition [
	self slotName: aSlotDefinition slotName.
	self componentName: self slotName , 'LabelAndInput'.
	self addComponent: ((LuiModelLabel named: self slotNameLabel) initializeOnSlot: aSlotDefinition;
	yourself).
	self addComponent: (
		(aSlotDefinition defaultInputComponentClass named: self slotName)
			initializeOnSlot: aSlotDefinition;
			yourself)
]

{ #category : 'components' }
LuiLabelWithInputComponent >> inputComponent [
	^ self componentNamed: self slotName
]

{ #category : 'components' }
LuiLabelWithInputComponent >> labelComponent [
	^ self componentNamed: self slotNameLabel
]

{ #category : 'components' }
LuiLabelWithInputComponent >> model: aModel [
	self hasLabelComponent ifTrue: [
		self labelComponent valueAccessor model: aModel ].
	self hasInputComponent ifTrue: [
		self inputComponent valueAccessor model: aModel ]
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> slotName [
	^ slotName
]

{ #category : 'accessing' }
LuiLabelWithInputComponent >> slotName: anObject [
	slotName := anObject
]

{ #category : 'private' }
LuiLabelWithInputComponent >> slotNameLabel [
	^ self slotName , 'Label'
]
