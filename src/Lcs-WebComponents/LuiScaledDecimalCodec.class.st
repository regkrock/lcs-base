Class {
	#name : 'LuiScaledDecimalCodec',
	#superclass : 'LuiCodec',
	#instVars : [
		'numberOfDecimals'
	],
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'instance creation' }
LuiScaledDecimalCodec class >> newWithDecimals: aPositiveInteger [
	^ self new
		numberOfDecimals: aPositiveInteger;
		yourself 
]

{ #category : 'testing' }
LuiScaledDecimalCodec >> canCreate: anObject [
	^ anObject isKindOf: ScaledDecimal
]

{ #category : 'converting' }
LuiScaledDecimalCodec >> decode: aString [
	| number |
	number := (ScaledDecimal readFrom: aString) 
				asScaledDecimal: self numberOfDecimals.
	"(number isZero not and: [ (number = aString) not ])
		ifTrue: [ self error: 'Invalid number' ]."
	^ number
]

{ #category : 'converting' }
LuiScaledDecimalCodec >> encode: aScaledDecimal [
	^ (aScaledDecimal asScaledDecimal: self numberOfDecimals) greaseString
]

{ #category : 'accessing' }
LuiScaledDecimalCodec >> numberOfDecimals [
	^ numberOfDecimals
]

{ #category : 'accessing' }
LuiScaledDecimalCodec >> numberOfDecimals: anObject [
	numberOfDecimals := anObject
]
