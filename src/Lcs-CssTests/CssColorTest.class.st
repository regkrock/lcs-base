Class {
	#name : #CssColorTest,
	#superclass : #TestCase,
	#category : #'Lcs-CssTests-Tests'
}

{ #category : #tests }
CssColorTest >> testDnuNamedColor [
	| color |
	color := CssColor black.
	self assert: color colorDefinition colorName equals: 'black'.
	self assert: color displayString equals: 'black'.
]

{ #category : #tests }
CssColorTest >> testHSLColor [
	| color |
	color := CssColor hue: 33 saturation: 34 lightness: 35.
	self assert: color colorDefinition hue equals: 33.
	self assert: color colorDefinition saturation equals: 34.
	self assert: color colorDefinition lightness equals: 35.
	self assert: color displayString equals: 'hsl(33, 34, 35)'.
]

{ #category : #tests }
CssColorTest >> testHexColor [
	| color |
	color := CssColor hex: '#000'.
	self assert: color colorDefinition hex equals:'#000'.
	self assert: color displayString equals: '#000'.
]

{ #category : #tests }
CssColorTest >> testNamedColor [
	| color |
	color := CssColor named: 'black'.
	self assert: color colorDefinition colorName equals: 'black'.
	self assert: color displayString equals: 'black'.
]

{ #category : #tests }
CssColorTest >> testRGBColor [
	| color |
	color := CssColor red: 33 green: 34 blue: 35.
	self assert: color colorDefinition red equals: 33.
	self assert: color colorDefinition green equals: 34.
	self assert: color colorDefinition blue equals: 35.
	self assert: color displayString equals: 'rgb(33, 34, 35)'.
]
