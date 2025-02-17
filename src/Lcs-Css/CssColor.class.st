Class {
	#name : #CssColor,
	#superclass : #CssObject,
	#instVars : [
		'colorDefinition'
	],
	#category : #'Lcs-Css'
}

{ #category : #'reflective operations' }
CssColor class >> doesNotUnderstand: aMessage [
	(aMessage selector includes: ':')
		ifTrue: [ super doesNotUnderstand: aMessage ]
		ifFalse: [ ^ self named: aMessage selector asString ]
]

{ #category : #'instance creation' }
CssColor class >> hex: aString [ 
	^ self new 
		initializeHex: aString;
		yourself
]

{ #category : #'instance creation' }
CssColor class >> hue: aHue saturation: aSaturation lightness: aLightness [
	^self new 
		initializeHue: aHue saturation: aSaturation lightness: aLightness;
		yourself
]

{ #category : #'instance creation' }
CssColor class >> named: aString [
	^ self new
		initializeNamedColor: aString;
		yourself 
]

{ #category : #'instance creation' }
CssColor class >> red: aRedNumber green: aGreenNumber blue: aBlueNumber [
	^self new 
		initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber;
		yourself
]

{ #category : #accessing }
CssColor >> colorDefinition [
	^ colorDefinition
]

{ #category : #accessing }
CssColor >> colorDefinition: anObject [
	colorDefinition := anObject
]

{ #category : #printing }
CssColor >> displayString [
	^self colorDefinition displayString
]

{ #category : #initialize }
CssColor >> initializeHex: aString [ 
	self colorDefinition: (CssHexColorDefinition hex: aString) 
]

{ #category : #initialize }
CssColor >> initializeHue: aHue saturation: aSaturation lightness: aLightness [ 
	^ self colorDefinition: (
		CssHSLColorDefinition 
			hue: aHue
			saturation: aSaturation
			lightness: aLightness)
]

{ #category : #initialize }
CssColor >> initializeNamedColor: aString [ 
	self colorDefinition: (
		CssNamedColorDefinition newNamedColor: aString)
]

{ #category : #initialize }
CssColor >> initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber [ 
	^ self colorDefinition: (
		CssRGBColorDefinition 
			red: aRedNumber
			green: aGreenNumber
			blue: aBlueNumber)
]

{ #category : #printing }
CssColor >> prettyCssOn: aStream [ 
	self colorDefinition 
		ifNil: [aStream nextPutAll: 'Error: Color not defined'] 
		ifNotNil: [self colorDefinition prettyCssOn: aStream]
]

{ #category : #printing }
CssColor >> prettyPrintOn: aStream [ 
	self colorDefinition 
		ifNil: [aStream nextPutAll: 'Error: Color not defined'] 
		ifNotNil: [self colorDefinition prettyPrintOn: aStream]
]
