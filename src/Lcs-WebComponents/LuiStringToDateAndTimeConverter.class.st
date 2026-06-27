Class {
	#name : 'LuiStringToDateAndTimeConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiStringToDateAndTimeConverter >> convertFromString: aString [
	aString isString ifFalse: [ ^ nil ].
	^ [ DateAndTime fromString:aString ] on: Error do: [ :s | s return: nil ]
]
