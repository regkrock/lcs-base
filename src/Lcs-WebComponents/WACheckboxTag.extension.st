Extension { #name : 'WACheckboxTag' }

{ #category : '*Lcs-WebComponents' }
WACheckboxTag >> lcsText: anObject [
	anObject isNil ifTrue: [ ^ self ].
	anObject isEmpty ifTrue: [ ^ self ].
	self attributes at: 'value' put: anObject
]
