Extension { #name : 'WADateTimeLocalInputTag' }

{ #category : '*Lcs-WebComponents' }
WADateTimeLocalInputTag >> max: anInteger [
	self attributeAt: 'max' put: anInteger
]

{ #category : '*Lcs-WebComponents' }
WADateTimeLocalInputTag >> min: anInteger [
	self attributeAt: 'min' put: anInteger
]
