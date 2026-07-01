Extension { #name : 'LcsStringSlot' }

{ #category : '*Lcs-WebComponents' }
LcsStringSlot >> configureWidgetComponent: aWidgetComponent model: aModel [
	aWidgetComponent populateFromStringSlot: self
]

{ #category : '*Lcs-WebComponents' }
LcsStringSlot >> defaultInputComponentClass [
	^ LuiTextInput
]

{ #category : '*Lcs-WebComponents' }
LcsStringSlot >> initialValue: anObject [
	super initialValue:anObject printString
]
