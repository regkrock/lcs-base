Extension { #name : 'WAMonthInputTag' }

{ #category : '*Lcs-WebComponents' }
WAMonthInputTag >> max: anInteger [
	self attributeAt: 'max' put: anInteger
]

{ #category : '*Lcs-WebComponents' }
WAMonthInputTag >> min: anInteger [
	self attributeAt: 'min' put: anInteger
]
