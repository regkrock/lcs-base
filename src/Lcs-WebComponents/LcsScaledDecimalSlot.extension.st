Extension { #name : 'LcsScaledDecimalSlot' }

{ #category : '*Lcs-WebComponents' }
LcsScaledDecimalSlot >> configureWidgetComponent: aWidgetComponent [
	super configureWidgetComponent: aWidgetComponent.
	aWidgetComponent 
		toStringConverter: (LuiScaledDecimalStringConverter newWithDecimals: self numberOfDecimals);
		fromStringConverter: (LuiScaledDecimalStringConverter newWithDecimals: self numberOfDecimals).
]
