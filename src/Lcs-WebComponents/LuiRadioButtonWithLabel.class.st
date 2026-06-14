Class {
	#name : 'LuiRadioButtonWithLabel',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'components' }
LuiRadioButtonWithLabel >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName , '_' , (aSlotDefinition optionValueFor: self model)
]

{ #category : 'initialize' }
LuiRadioButtonWithLabel >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self
		componentName: (aSlotDefinition optionValueFor: aModel) , '_RadioButtonAndLabel'.
	self
		addComponent: (
			LuiRadioButton
				onSlot: aSlotDefinition
				model: aModel).
	self
		addComponent: (
			(LuiLabel
					onSlot: aSlotDefinition
					model: aModel
					componentName: (aSlotDefinition optionValueFor: aModel)
							, '_RadioButtonLabel')
				removeForNameAttribute;
				text: (aSlotDefinition optionDisplayStringFor: aModel);
				yourself)
]
