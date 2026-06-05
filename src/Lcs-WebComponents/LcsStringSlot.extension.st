Extension { #name : 'LcsStringSlot' }

{ #category : '*Lcs-WebComponents' }
LcsStringSlot >> defaultInputComponentClass [
	^ LuiTextInput
]

{ #category : '*Lcs-WebComponents' }
LcsStringSlot >> initialValue: anObject [
	super initialValue:anObject printString
]
