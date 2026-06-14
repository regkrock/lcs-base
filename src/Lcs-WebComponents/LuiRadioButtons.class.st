Class {
	#name : 'LuiRadioButtons',
	#superclass : 'LuiModelWidget',
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
			removeForNameAttribute;
			text: (aSlotDefinition optionDisplayStringFor: anItem);
			yourself)
]

{ #category : 'initialize' }
LuiRadioButtons >> addRadioButtonWithLabel: aSlotDefinition basedOn: anItem [ 
	self addComponent: (LuiRadioButtonWithLabel onSlot: aSlotDefinition model: anItem)
]

{ #category : 'initialize' }
LuiRadioButtons >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: (aString , 'RadioButtons').
	aSlotDefinition targetCollection
		sorted: [ :a :b | 
			(aSlotDefinition displayStringBlock cull: a cull: aSlotDefinition)
				<= (aSlotDefinition displayStringBlock cull: b cull: aSlotDefinition) ]
		do: [ :eachItem | self addRadioButtonWithLabel: aSlotDefinition basedOn: eachItem ]
]
