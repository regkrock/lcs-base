Class {
	#name : 'LuiRadioButton',
	#superclass : 'LuiFormInputComponent',
	#instVars : [
		'optionValue',
		'item',
		'postSiblingComponents',
		'anteSiblingComponents'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiRadioButton >> componentAttributesClass [
	^ LuiOptionAttributes
]

{ #category : 'initialize' }
LuiRadioButton >> componentNameBaseOn: aSlotDefinition [
	^ 'radio_' , (aSlotDefinition optionValueFor: self model)
]

{ #category : 'initialize' }
LuiRadioButton >> initializeOnSlot: aSlotDefinition model: aModel [
	super initializeOnSlot: aSlotDefinition model: aModel.
	self optionValue: (aSlotDefinition optionValueFor: aModel)
]

{ #category : 'accessing' }
LuiRadioButton >> name [
	^ self attributes name
]

{ #category : 'accessing' }
LuiRadioButton >> name: anObject [
	self attributes name: anObject
]

{ #category : 'accessing' }
LuiRadioButton >> optionValue [
	^ self attributes optionValue
]

{ #category : 'accessing' }
LuiRadioButton >> optionValue: anObject [
	self attributes optionValue: anObject
]

{ #category : 'rendering' }
LuiRadioButton >> renderComponentOn: html [
	html radioButton
		addCommonAttributes: self;
		selected: false;
		with: [ self renderDetailsOn: html ]
]
