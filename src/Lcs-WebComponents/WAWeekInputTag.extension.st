Extension { #name : 'WAWeekInputTag' }

{ #category : '*Lcs-WebComponents' }
WAWeekInputTag >> max: anInteger [
	self attributeAt: 'max' put: anInteger
]

{ #category : '*Lcs-WebComponents' }
WAWeekInputTag >> min: anInteger [
	self attributeAt: 'min' put: anInteger
]
