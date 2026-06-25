Extension { #name : 'LcsDateSlot' }

{ #category : '*Lcs-WebComponents' }
LcsDateSlot >> configureWidgetComponent: aWidgetComponent [
	aWidgetComponent 
		"step: self stepValue;"
		min: (self minimum ifNotNil: [ :date | date yyyymmdd ]) ;
		max: (self maximum ifNotNil: [ :date | date yyyymmdd ]) 
]

{ #category : '*Lcs-WebComponents' }
LcsDateSlot >> defaultInputComponentClass [
	^ LuiDateInput
]
