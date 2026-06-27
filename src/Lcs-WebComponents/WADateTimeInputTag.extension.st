Extension { #name : 'WADateTimeInputTag' }

{ #category : '*Lcs-WebComponents' }
WADateTimeInputTag >> max: anInteger [
	self attributeAt: 'max' put: anInteger
]

{ #category : '*Lcs-WebComponents' }
WADateTimeInputTag >> min: anInteger [
	self attributeAt: 'min' put: anInteger
]
