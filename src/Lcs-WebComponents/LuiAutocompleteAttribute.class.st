Class {
	#name : 'LuiAutocompleteAttribute',
	#superclass : 'LuiComponentAttribute',
	#instVars : [
		'cssClasses'
	],
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant\t' }
LuiAutocompleteAttribute class >> attributeName [
	^ 'autocomplete'
]

{ #category : 'css classes' }
LuiAutocompleteAttribute >> autocomplete [
	^ self cachedValue
]

{ #category : 'css classes' }
LuiAutocompleteAttribute >> autocomplete: aString [
	self valueBlock: [ aString ]
]

{ #category : 'initialize' }
LuiAutocompleteAttribute >> initialize [
	super initialize.
	self valueBlock: [ '' ]
]
