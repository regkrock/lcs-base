Class {
	#name : #CssFile,
	#superclass : #CssObject,
	#instVars : [
		'cssVariables'
	],
	#category : #'Lcs-Css'
}

{ #category : #pragmas }
CssFile class >> cssVariableMethods [
	| methods |
	methods := Set new.
	self methodDict do: [:eachValue | eachValue pragmas do: [ :each | (each selector = #cssVariable) ifTrue: [methods add: eachValue]] ].
	^ methods 
]

{ #category : #variables }
CssFile >> backgroundColor [
	<cssVariable>
	^ CssVariable newName: 'primaryColor' value: (CssColor white) displayString
]

{ #category : #accessing }
CssFile >> cssVariables [
	^ cssVariables
]

{ #category : #accessing }
CssFile >> cssVariables: anObject [
	cssVariables := anObject
]

{ #category : #'file creation' }
CssFile >> generateFile [
	^ self 
]

{ #category : #initialize }
CssFile >> initialize [
	self cssVariables: Dictionary new.
	self initializeCssVariables.
]

{ #category : #initialize }
CssFile >> initializeCssVariables [
	| cssVariable |
	self class cssVariableMethods do: [:each | 
	cssVariable := (self perform: each selector).
	self cssVariables at: cssVariable variableName put: cssVariable ]
]

{ #category : #variables }
CssFile >> primaryColorVariable [
	<cssVariable>
	^ CssVariable newName: 'primaryColor' value: (CssColor named:'black') displayString
]
