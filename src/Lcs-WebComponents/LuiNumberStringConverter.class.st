Class {
	#name : 'LuiNumberStringConverter',
	#superclass : 'LuiDisplayConverter',
	#instVars : [
		'numberOfDecimals'
	],
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiNumberStringConverter >> convertFromString: aString [
	" (self new convertFromString: '10.020304') = 10.020304 "
	| number |
	number := Number readFrom: aString.
	number greaseString = aString ifFalse: [ self error: 'Invalid number' ].
	^ number
]

{ #category : 'converting' }
LuiNumberStringConverter >> convertToString: aNumber [
	aNumber ifNil: [ ^ '' ].
	^ aNumber greaseString
]
