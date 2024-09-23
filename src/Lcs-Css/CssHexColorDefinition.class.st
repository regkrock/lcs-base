Class {
	#name : #CssHexColorDefinition,
	#superclass : #CssColorDefinition,
	#instVars : [
		'hex'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instace creation' }
CssHexColorDefinition class >> hex: aString [ 
	^ self new
		hex: aString;
		yourself
]

{ #category : #accessing }
CssHexColorDefinition >> hex [
	^ hex
]

{ #category : #iniitialize }
CssHexColorDefinition >> hex: aString [ 
	hex := aString
]

{ #category : #'as yet unclassified' }
CssHexColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: self hex asString
]
