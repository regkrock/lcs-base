Class {
	#name : #CssRGBColorDefinition,
	#superclass : #CssColorDefinition,
	#instVars : [
		'green',
		'blue',
		'red',
		'alpha'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance creation' }
CssRGBColorDefinition class >> red: aRedNumber green: aGreenNumber blue: aBlueNumber [ 

	^ self new
		initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber
]

{ #category : #accessing }
CssRGBColorDefinition >> blue [
	^ blue
]

{ #category : #initialize }
CssRGBColorDefinition >> blue: aBlueNumber [ 
	blue := aBlueNumber
]

{ #category : #accessing }
CssRGBColorDefinition >> green [
	^ green
]

{ #category : #initialize }
CssRGBColorDefinition >> green: aGreenNumber [ 
	green := aGreenNumber
]

{ #category : #initialize }
CssRGBColorDefinition >> initializeRed: aRedNumber green: aGreenNumber blue: aBlueNumber [ 
	self 
		red: aRedNumber;
		green: aGreenNumber;
		blue: aBlueNumber
]

{ #category : #printing }
CssRGBColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: 'rgb(';
		nextPutAll: self red asString;
		nextPutAll: ', ';
		nextPutAll: self green asString;
		nextPutAll: ', ';
		nextPutAll: self blue asString;
		nextPutAll: ')'
]

{ #category : #accessing }
CssRGBColorDefinition >> red [
	^ red
]

{ #category : #accessing }
CssRGBColorDefinition >> red: aRedNumber [ 
	red := aRedNumber
]
