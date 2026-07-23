Class {
	#name : 'LuiScaledDecimalInput',
	#superclass : 'LuiNumberInput',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiScaledDecimalInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self codec: (LuiScaledDecimalCodec newWithDecimals: aSlotDefinition numberOfDecimals).

	self 
		step: aSlotDefinition stepValue;
		min: aSlotDefinition minimum;
		max: aSlotDefinition maximum
]
