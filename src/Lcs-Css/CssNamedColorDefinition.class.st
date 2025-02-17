Class {
	#name : #CssNamedColorDefinition,
	#superclass : #CssColorDefinition,
	#instVars : [
		'colorName'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance creation' }
CssNamedColorDefinition class >> newNamedColor: aString [ 
	^ self new
		colorName: aString;
		yourself
]

{ #category : #accessing }
CssNamedColorDefinition >> colorName [
	^ colorName
]

{ #category : #accessing }
CssNamedColorDefinition >> colorName: anObject [
	colorName := anObject
]

{ #category : #printing }
CssNamedColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: self colorName  asString
]
