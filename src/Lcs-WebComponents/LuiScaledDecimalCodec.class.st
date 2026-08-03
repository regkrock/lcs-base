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
	^ ((ScaledDecimal readFromString: aString) asScaledDecimal: self numberOfDecimals)
]

{ #category : 'converting' }
LuiScaledDecimalCodec >> encode: aScaledDecimal [
	^ aScaledDecimal greaseString
]

{ #category : 'accessing' }
LuiScaledDecimalCodec >> numberOfDecimals [
	^ numberOfDecimals
]

{ #category : 'accessing' }
LuiScaledDecimalCodec >> numberOfDecimals: anObject [
	numberOfDecimals := anObject
]
