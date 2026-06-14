Class {
	#name : 'LuiOption',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'optionValue',
		'item'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiOption >> componentNameBaseOn: aSlotDefinition [
	^ 'option_' , (aSlotDefinition optionValueFor: self model)
]

{ #category : 'initialize' }
LuiOption >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self optionValue: (aSlotDefinition optionValueFor: aModel).
	self text: (aSlotDefinition optionDisplayStringFor: aModel).
	self componentName: 'option_' , self optionValue asString
]

{ #category : 'accessing' }
LuiOption >> item [
	^ item
]

{ #category : 'accessing' }
LuiOption >> item: anObject [
	item := anObject
]

{ #category : 'accessing' }
LuiOption >> optionValue [
	^ optionValue
]

{ #category : 'accessing' }
LuiOption >> optionValue: anObject [
	optionValue := anObject
]

{ #category : 'rendering' }
LuiOption >> renderComponentOn: html [
	html option
		addCommonAttributes: self;
		selected: false;
		value: self optionValue;
		label: self text
]
