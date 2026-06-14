Class {
	#name : 'LuiCheckboxAndLabel',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'inputComponentName',
		'labelComponentName'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiCheckboxAndLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self inputComponentName: aSlotDefinition slotName.
	self labelComponentName: aSlotDefinition slotName , 'Label'.
	self addComponent: (LuiCheckbox onSlot: aSlotDefinition model: aModel componentName: self inputComponentName).
	self addComponent: ((LuiLabel onSlot:  aSlotDefinition model: aModel componentName: self labelComponentName)
							forName: aSlotDefinition slotName;
							yourself)
]

{ #category : 'components' }
LuiCheckboxAndLabel >> inputComponent [
	^ self componentNamed: self inputComponentName
]

{ #category : 'components' }
LuiCheckboxAndLabel >> inputComponentName [
	^ inputComponentName
]

{ #category : 'accessing' }
LuiCheckboxAndLabel >> inputComponentName: anObject [
	inputComponentName := anObject
]

{ #category : 'components' }
LuiCheckboxAndLabel >> labelComponent [
	^ self componentNamed: self labelComponentName
]

{ #category : 'accessing' }
LuiCheckboxAndLabel >> labelComponentName [
	^ labelComponentName
]

{ #category : 'accessing' }
LuiCheckboxAndLabel >> labelComponentName: anObject [
	labelComponentName := anObject
]

{ #category : 'rendering' }
LuiCheckboxAndLabel >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
