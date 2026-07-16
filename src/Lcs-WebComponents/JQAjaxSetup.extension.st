Extension { #name : 'JQAjaxSetup' }

{ #category : '*Lcs-WebComponents' }
JQAjaxSetup >> lcsOnSuccess: anObject [
	anObject isNil ifTrue: [ ^ self ].
	self onSuccess: anObject
]
