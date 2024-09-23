Class {
	#name : #CssRGBSColorDefinition,
	#superclass : #CssRGBColorDefinition,
	#category : #'Lcs-Css'
}

{ #category : #accessing }
CssRGBSColorDefinition >> alpha [
	^ alpha
]

{ #category : #accessing }
CssRGBSColorDefinition >> alpha: anObject [
	alpha := anObject
]

{ #category : #initialialize }
CssRGBSColorDefinition >> initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber alpha: anAlphaNumber [
	super initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber.
	self alpha: anAlphaNumber
]

{ #category : #printing }
CssRGBSColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: 'rgba(';
		nextPutAll: self red asString;
		nextPutAll: ', ';
		nextPutAll: self green asString;
		nextPutAll: ', ';
		nextPutAll: self blue asString;
		nextPutAll: ', ';
		nextPutAll: self alpha asString;
		nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
CssRGBSColorDefinition >> red: aRedNumber green: aGreenNumber blue: aBlueNumber alpha: anAlphaNumber [
]
