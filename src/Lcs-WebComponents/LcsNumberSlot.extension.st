Extension { #name : 'LcsNumberSlot' }

{ #category : '*Lcs-WebComponents' }
LcsNumberSlot >> configureWidgetComponent: aWidgetComponent model: aModel [
	aWidgetComponent 
		step: self stepValue;
		min: self minimum;
		max: self maximum
]

{ #category : '*Lcs-WebComponents' }
LcsNumberSlot >> defaultInputComponentClass [
	^ LuiNumberInput
]
