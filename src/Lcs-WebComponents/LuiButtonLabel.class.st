Class {
	#name : 'LuiButtonLabel',
	#superclass : 'LuiFormInputComponent',
	#instVars : [
		'valueBlock',
		'cachedValue'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'accessing' }
LuiButtonLabel >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self valueBlock value ]
]

{ #category : 'accessing' }
LuiButtonLabel >> cachedValue: anObject [
	cachedValue := anObject
]

{ #category : 'accessing' }
LuiButtonLabel >> clearCachedValue [
	self cachedValue: nil
]

{ #category : 'initialize' }
LuiButtonLabel >> initialize [
	super initialize.
	self valueBlock: [ '' ]
]

{ #category : 'label' }
LuiButtonLabel >> labelString [
	^ self text
]

{ #category : 'configuration' }
LuiButtonLabel >> labelString: aString [
	self text: aString
]

{ #category : 'rendering' }
LuiButtonLabel >> renderComponentOn: html [
	html span
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'rendering' }
LuiButtonLabel >> renderDetailsOn: html [
	html text: self labelString
]

{ #category : 'accessing' }
LuiButtonLabel >> text [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiButtonLabel >> text: aString [
	self valueBlock: [ aString ].
	self clearCachedValue
]

{ #category : 'accessing' }
LuiButtonLabel >> valueBlock [
	^ valueBlock
]

{ #category : 'accessing' }
LuiButtonLabel >> valueBlock: aBlock [
	valueBlock := aBlock
]
