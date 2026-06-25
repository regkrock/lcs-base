Extension { #name : 'WADateInputTag' }

{ #category : '*Lcs-WebComponents' }
WADateInputTag >> max: anInteger [
	self attributeAt: 'max' put: anInteger
]

{ #category : '*Lcs-WebComponents' }
WADateInputTag >> min: anInteger [
	self attributeAt: 'min' put: anInteger
]
