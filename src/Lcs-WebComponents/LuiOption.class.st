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
	self componentName: 'option_' , self optionValue asString.
	self callback: [ :value | self halt handleCallbackValue: value ]
]

{ #category : 'testing' }
LuiOption >> isSelected [
	^ self parentComponent selection = self optionModel
]

{ #category : 'accessing' }
LuiOption >> item [
	^ item
]

{ #category : 'accessing' }
LuiOption >> item: anObject [
	item := anObject
]

{ #category : 'model' }
LuiOption >> optionModel [
	^ self valueAccessor model
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
		callback: [ :value | 
			self halt.
			self parentComponent handleCallbackValue: value element: self optionModel ];
		selected: self isSelected;
		value: self optionValue;
		label: self text
]

{ #category : 'components' }
LuiOption >> selectComponent [
	^ self parentComponent
]
