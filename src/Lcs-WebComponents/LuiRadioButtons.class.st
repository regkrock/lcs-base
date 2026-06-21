Class {
	#name : 'LuiRadioButtons',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'selected',
		'callbackBlock'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiRadioButtons >> addRadioButton: aSlotDefinition basedOn: anItem [ 
	self addComponent: (LuiRadioButton onSlot: aSlotDefinition model: anItem).
	self addComponent: (
		(LuiLabel onSlot: aSlotDefinition model: anItem)
			componentName: 'label';
			removeForAttribute;
			text: (aSlotDefinition optionDisplayStringFor: anItem);
			yourself)
]

{ #category : 'initialize' }
LuiRadioButtons >> addRadioButtonWithLabel: aSlotDefinition basedOn: anItem [ 
	self addComponent: (LuiRadioButtonWithLabel onSlot: aSlotDefinition model: anItem)
]

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

{ #category : 'gt views' }
LuiRadioButtons >> gtViewTagName [
	^'div'
]

{ #category : 'initialize' }
LuiRadioButtons >> handleCallbackValue: value [
	| model |
	model := "self modelForOptionValue:" value.
	self selected: model.
	^ self valueAccessor write: model
]

{ #category : 'initialize' }
LuiRadioButtons >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString , 'RadioButtons'.
	aSlotDefinition targetCollection
		sorted: [ :a :b | 
			(aSlotDefinition displayStringBlock cull: a cull: aSlotDefinition)
				<= (aSlotDefinition displayStringBlock cull: b cull: aSlotDefinition) ]
		do: [ :eachItem | self addRadioButtonWithLabel: aSlotDefinition basedOn: eachItem ].
	self selected: self valueAccessor read.
	self callbackBlock: [ :value | self handleCallbackValue: value ]
]

{ #category : 'query' }
LuiRadioButtons >> modelForOptionValue: aString [
	self components do: [ :each |
		(each modelForOptionValue: aString) ifNotNil: [ :model | ^ model ] ].
	^ nil
]

{ #category : 'rendering' }
LuiRadioButtons >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [
			html radioGroup
				callback: self callbackBlock;
				selected: self valueAccessor read;
				with: [ :group | self renderDetailsOn: html group: group] ]
]

{ #category : 'rendering' }
LuiRadioButtons >> renderDetailsOn: html group: aGroup [ 
	self orderedComponents do: [ :each |
		each renderComponentOn: html group: aGroup ] 
]

{ #category : 'accessing' }
LuiRadioButtons >> selected [
	^ selected
]

{ #category : 'accessing' }
LuiRadioButtons >> selected: anObject [
	selected := anObject
]
