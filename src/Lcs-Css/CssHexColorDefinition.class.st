Class {
	#name : #CssHexColorDefinition,
	#superclass : #CssColorDefinition,
	#instVars : [
		'hex'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance creation' }
CssHexColorDefinition class >> hex: aString [ 
	^ self new
		hex: aString;
		yourself
]

{ #category : #accessing }
CssHexColorDefinition >> hex [
	^ hex
]

{ #category : #initialize }
CssHexColorDefinition >> hex: aString [ 
	hex := aString
]

{ #category : #'as yet unclassified' }
CssHexColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: self hex asString
]
