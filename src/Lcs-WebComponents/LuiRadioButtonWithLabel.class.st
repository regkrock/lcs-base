Class {
	#name : 'LuiRadioButtonWithLabel',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'labelComponentName',
		'radioButtonComponentName'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'components - updating' }
LuiRadioButtonWithLabel >> assignInputIdToLabelForId [
	self labelComponent for: self radioButtonComponent componentId
]

{ #category : 'components' }
LuiRadioButtonWithLabel >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName , '_' , (aSlotDefinition optionValueFor: self model)
]

{ #category : 'defaults' }
LuiRadioButtonWithLabel >> defaultCssClasses [
	^ OrderedCollection with: 'radioButtonAndLabel'
]

{ #category : 'initialize' }
LuiRadioButtonWithLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	| buttonComponent |
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: (aSlotDefinition optionValueFor: aModel) , '_RadioButtonAndLabel'.

	self
		addComponent: (
			buttonComponent := LuiRadioButton
				onSlot: aSlotDefinition
				model: aModel).
	self radioButtonComponentName: buttonComponent componentName.
	self labelComponentName: (aSlotDefinition optionValueFor: aModel)
							, '_RadioButtonLabel'.
	self
		addComponent: (
			(LuiLabel
					onSlot: aSlotDefinition
					model: aModel
					componentName: self labelComponentName)
				removeForAttribute;
				text: (aSlotDefinition optionDisplayStringFor: aModel);
				yourself)
]

{ #category : 'components' }
LuiRadioButtonWithLabel >> labelComponent [
	^ self componentNamed: self labelComponentName
]

{ #category : 'accessing' }
LuiRadioButtonWithLabel >> labelComponentName [
	^ labelComponentName
]

{ #category : 'accessing' }
LuiRadioButtonWithLabel >> labelComponentName: anObject [
	labelComponentName := anObject
]

{ #category : 'query' }
LuiRadioButtonWithLabel >> modelForOptionValue: aString [
	self radioButtonComponentName = aString
		ifTrue: [ ^ self valueAccessor model ].
	^ nil
]

{ #category : 'components' }
LuiRadioButtonWithLabel >> radioButtonComponent [
	^ self componentNamed: self radioButtonComponentName
]

{ #category : 'accessing' }
LuiRadioButtonWithLabel >> radioButtonComponentName [
	^ radioButtonComponentName
]

{ #category : 'accessing' }
LuiRadioButtonWithLabel >> radioButtonComponentName: anObject [
	radioButtonComponentName := anObject
]

{ #category : 'rendering' }
LuiRadioButtonWithLabel >> renderComponentOn: html [
	"This is here for consistency. There should be a group?"
	self renderComponentOn: html group: nil
]

{ #category : 'rendering' }
LuiRadioButtonWithLabel >> renderComponentOn: html group: aGroup [
	self radioButtonComponent renderComponentOn: html group: aGroup.
	self labelComponent renderComponentOn: html
]
