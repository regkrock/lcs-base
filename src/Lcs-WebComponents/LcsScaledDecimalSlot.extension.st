Extension { #name : 'LcsScaledDecimalSlot' }

{ #category : '*Lcs-WebComponents' }
LcsScaledDecimalSlot >> configureWidgetComponent: aWidgetComponent [
	super configureWidgetComponent: aWidgetComponent.
	aWidgetComponent 
		converter: (LuiScaledDecimalStringConverter newWithDecimals: self numberOfDecimals).
]
