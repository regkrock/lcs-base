Class {
	#name : 'LuiScaledDecimalStringConverter',
	#superclass : 'LuiDisplayConverter',
	#instVars : [
		'numberOfDecimals'
	],
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'instance creation' }
LuiScaledDecimalStringConverter class >> newWithDecimals: aPositiveInteger [
	^ self new
		numberOfDecimals: aPositiveInteger;
		yourself 
]

{ #category : 'converting' }
LuiScaledDecimalStringConverter >> convertFromString: aString [
	| number |
	number := (ScaledDecimal readFrom: aString)
			asScaledDecimal: self numberOfDecimals.
	"(number isZero not and: [ (number = aString) not ])
		ifTrue: [ self error: 'Invalid number' ]."
	^ number
]

{ #category : 'converting' }
LuiScaledDecimalStringConverter >> convertToString: aScaledDecimal [
	^ (aScaledDecimal asScaledDecimal: self numberOfDecimals) greaseString
]

{ #category : 'accessing' }
LuiScaledDecimalStringConverter >> numberOfDecimals [
	^ numberOfDecimals
]

{ #category : 'accessing' }
LuiScaledDecimalStringConverter >> numberOfDecimals: anObject [
	numberOfDecimals := anObject
]
