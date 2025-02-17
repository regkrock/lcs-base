Class {
	#name : #CssHSLColorDefinition,
	#superclass : #CssColorDefinition,
	#category : #'Lcs-Css'
}

{ #category : #'instance creation' }
CssHSLColorDefinition class >> hue: aHue saturation: aSaturation lightness: aLightness [
	^ self new 
		initializeHue: aHue saturation: aSaturation lightness: aLightness;
		yourself
]

{ #category : #accessing }
CssHSLColorDefinition >> hue [
	^ hue
]

{ #category : #accessing }
CssHSLColorDefinition >> hue: anObject [
	hue := anObject
]

{ #category : #initialize }
CssHSLColorDefinition >> initializeHue: aHue saturation: aSaturation lightness: aLightness [ 
	self 
		hue: aHue;
		saturation: aSaturation;
		lightness: aLightness
]

{ #category : #accessing }
CssHSLColorDefinition >> lightness [
	^ lightness
]

{ #category : #accessing }
CssHSLColorDefinition >> lightness: anObject [
	lightness := anObject
]

{ #category : #printing }
CssHSLColorDefinition >> prettyPrintOn: aStream [ 
	aStream 
		nextPutAll: 'hsl(';
		nextPutAll: self hue asString;
		nextPutAll: ', ';
		nextPutAll: self saturation asString;
		nextPutAll: ', ';
		nextPutAll: self lightness asString;
		nextPutAll: ')'
]

{ #category : #accessing }
CssHSLColorDefinition >> saturation [
	^ saturation
]

{ #category : #accessing }
CssHSLColorDefinition >> saturation: anObject [
	saturation := anObject
]
