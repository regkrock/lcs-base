Extension { #name : 'LcsScaledDecimalSlot' }

{ #category : '*Lcs-WebComponents' }
LcsScaledDecimalSlot >> configureWidgetComponent: aWidgetComponent model: aModel [
	super configureWidgetComponent: aWidgetComponent model: aModel.
	aWidgetComponent
		toStringConverter: (LuiScaledDecimalStringConverter newWithDecimals: self numberOfDecimals);
		fromStringConverter: (LuiScaledDecimalStringConverter newWithDecimals: self numberOfDecimals)
]
