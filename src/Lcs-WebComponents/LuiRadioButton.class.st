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

{ #category : 'gt views' }
LuiRadioButton >> gtViewTagName [
	^ super gtViewTagName ,  ' type=''radio'''
]

{ #category : 'callbacks' }
LuiRadioButton >> handleCallbackValue: value [ 
	self valueAccessor write: value
]

{ #category : 'initialize' }
LuiRadioButton >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self optionValue: (aSlotDefinition optionValueFor: aModel).
	self componentName: self optionValue asString , '_RadioButton'
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
	"This is here for consistency. There should be a group?"
	self renderComponentOn: html group: nil
]

{ #category : 'rendering' }
LuiRadioButton >> renderComponentOn: html group: aGroup [
	(html radioButton)
		addCommonAttributes: self;
		value: self optionValue
]
