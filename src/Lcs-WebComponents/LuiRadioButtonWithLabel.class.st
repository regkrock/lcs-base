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
LuiRadioButtonWithLabel >> initializeOnSlot: aSlotDefinition model: aModel [
	super initializeOnSlot: aSlotDefinition model: aModel.
	self addComponent: (LuiRadioButton onSlot: aSlotDefinition model: aModel).
	self addComponent: (
		(LuiLabel onSlot: aSlotDefinition model: aModel)
			componentName: 'label';
			removeForName;
			text: (aSlotDefinition optionDisplayStringFor: aModel);
			yourself)
]
