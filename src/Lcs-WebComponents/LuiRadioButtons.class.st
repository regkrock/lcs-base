Class {
	#name : 'LuiRadioButtons',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'selected',
		'callbackBlock',
		'elements'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'accessing' }
LuiRadioButtons >> callbackBlock [
	^ callbackBlock
]

{ #category : 'accessing' }
LuiRadioButtons >> callbackBlock: anObject [
	callbackBlock := anObject
]

{ #category : 'defaults' }
LuiRadioButtons >> defaultCssClasses [
	^ OrderedCollection with: 'radioButtons'
]

{ #category : 'initialize' }
LuiRadioButtons >> displayStringFor: a [
	^ self slotDefinition displayStringBlock cull: a cull: self slotDefinition
]

{ #category : 'accessing' }
LuiRadioButtons >> elements [
	^ elements
]

{ #category : 'accessing' }
LuiRadioButtons >> elements: anObject [
	elements := anObject
]

{ #category : 'gt views' }
LuiRadioButtons >> gtViewTagName [
	^'div'
]

{ #category : 'callbacks' }
LuiRadioButtons >> handleCallbackValue: value [
	self selected: value
]

{ #category : 'initialize' }
LuiRadioButtons >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self elements: self optionModelsInDisplayOrder.
	self callbackBlock: [ :value | self handleCallbackValue: value ]
]

{ #category : 'initialize' }
LuiRadioButtons >> optionModelsInDisplayOrder [
	^ self slotDefinition targetCollection
		sorted: [ :a :b | (self displayStringFor: a) <= (self displayStringFor: b) ]
]

{ #category : 'rendering' }
LuiRadioButtons >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [
			html radioGroup
				callback: [ :value | self handleCallbackValue: value ];
				selected: self valueAccessor read;
				with: [ :group | 
					self renderElementComponentsIn: group on: html ] ]
]

{ #category : 'rendering' }
LuiRadioButtons >> renderElementComponentsIn: group on: html [ 
	self elements doWithIndex: [ :each :index |
		| buttonId |
		buttonId := self componentId asString , '_' , index asString.
		group radioButton 
			id: buttonId;
			value: each.
		html label 
			id: (buttonId , '_Label');
			for: buttonId;
			with:  (self displayStringFor: each)]
]

{ #category : 'accessing' }
LuiRadioButtons >> selected [
	^ self valueAccessor read
]

{ #category : 'accessing' }
LuiRadioButtons >> selected: aModel [
	self valueAccessor write: aModel
]

{ #category : 'model' }
LuiRadioButtons >> slotDefinition [
	^ self valueAccessor slotDefinition
]
