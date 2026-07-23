Class {
	#name : 'LuiNumberCodec',
	#superclass : 'LuiCodec',
	#instVars : [
		'numberOfDecimals'
	],
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiNumberCodec >> canCreate: anObject [
	^ anObject isNumber
]

{ #category : 'converting' }
LuiNumberCodec >> decode: aString [
	" (self new convertFromString: '10.020304') = 10.020304 "
	| number |
	number := Number readFrom: aString.
	number greaseString = aString ifFalse: [ self error: 'Invalid number' ].
	^ number
]

{ #category : 'converting' }
LuiNumberCodec >> encode: aNumber [
	aNumber ifNil: [ ^ '' ].
	^ aNumber greaseString
]
