Extension { #name : 'LcsDelegatorSlot' }

{ #category : '*Lcs-WebComponents' }
LcsDelegatorSlot >> configureWidgetComponent: aWidgetComponent model: aModel [
	(self sourceSlotFor: aModel)
		configureWidgetComponent: aWidgetComponent
		model: aModel
]
