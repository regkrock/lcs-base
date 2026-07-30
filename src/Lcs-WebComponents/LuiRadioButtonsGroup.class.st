Class {
	#name : 'LuiRadioButtonsGroup',
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

{ #category : 'components updating' }
LuiRadioButtonsGroup >> assignInputIdToLabelForId [
	(Interval from: 1 to: self orderedComponents size by: 2) do: [ :index | 
		| labelComponent radioButtonComponent |
		labelComponent := self orderedComponents at: index + 1.
		radioButtonComponent := self orderedComponents at: index.
		labelComponent for: radioButtonComponent componentId ].
]

{ #category : 'defaults' }
LuiRadioButtonsGroup >> defaultCssClasses [
	^ OrderedCollection with: 'radioButtons'
]

{ #category : 'initialize' }
LuiRadioButtonsGroup >> displayStringFor: a [
	^ self slotDefinition displayStringBlock cull: a cull: self slotDefinition
]

{ #category : 'accessing' }
LuiRadioButtonsGroup >> elements [
	^ elements
]

{ #category : 'accessing' }
LuiRadioButtonsGroup >> elements: anObject [
	elements := anObject
]

{ #category : 'gt views' }
LuiRadioButtonsGroup >> gtViewTagName [
	^'div'
]

{ #category : 'callbacks' }
LuiRadioButtonsGroup >> handleCallbackValue: value [
	self selected: value
]

{ #category : 'initialize' }
LuiRadioButtonsGroup >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self elements: self optionModelsInDisplayOrder.
	self elements doWithIndex: [ :each :index |
		| buttonName |
		buttonName := self componentName , '_' , index asString.
		self addComponent: (
			LuiRadioButton 
				onSlot: self slotDefinition 
				model: each 
				componentName: buttonName).
		self addComponent: (
			(LuiLabel onSlot: self slotDefinition model: each componentName: buttonName , '_label')
				for: buttonName;
				text: (self slotDefinition displayStringBlock cull: each cull: self slotDefinition);
				yourself)
		]
]

{ #category : 'initialize' }
LuiRadioButtonsGroup >> optionModelsInDisplayOrder [
	^ self slotDefinition targetCollection
		sorted: [ :a :b | (self displayStringFor: a) <= (self displayStringFor: b) ]
]

{ #category : 'rendering' }
LuiRadioButtonsGroup >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'accessing' }
LuiRadioButtonsGroup >> selected [
	^ self valueAccessor read
]

{ #category : 'accessing' }
LuiRadioButtonsGroup >> selected: aModel [
	self valueAccessor write: aModel
]

{ #category : 'model' }
LuiRadioButtonsGroup >> slotDefinition [
	^ self valueAccessor slotDefinition
]
