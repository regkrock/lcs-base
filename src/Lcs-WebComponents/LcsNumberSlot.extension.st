Extension { #name : 'LcsNumberSlot' }

{ #category : '*Lcs-WebComponents' }
LcsNumberSlot >> configureWidgetComponent: aWidgetComponent [
	aWidgetComponent 
		step: self stepValue;
		min: self minimum;
		max: self maximum
]

{ #category : '*Lcs-WebComponents' }
LcsNumberSlot >> defaultInputComponentClass [
	^ LuiNumberInput
]
