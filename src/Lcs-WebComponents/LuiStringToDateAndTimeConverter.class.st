Class {
	#name : 'LuiStringToDateAndTimeConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiStringToDateAndTimeConverter >> value: aString [
	aString isString ifFalse: [ ^ nil ].
	^ [ aString asDateAndTime ] on: Error do: [ :s | s return: nil ]
]
