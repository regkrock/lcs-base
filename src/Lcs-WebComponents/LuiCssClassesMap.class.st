Class {
	#name : 'LuiCssClassesMap',
	#superclass : 'LcsObject',
	#instVars : [
		'cssClassesMap'
	],
	#classInstVars : [
		'Singleton'
	],
	#category : 'Lcs-WebComponents-Libraries',
	#package : 'Lcs-WebComponents',
	#tag : 'Libraries'
}

{ #category : 'accessing' }
LuiCssClassesMap class >> / aSymbol [
	^ self singleton cssClassFor: aSymbol
]

{ #category : 'accessing' }
LuiCssClassesMap class >> singleton [
	^ Singleton ifNil: [ Singleton := self basicNew initialize ]
]

{ #category : 'accessing' }
LuiCssClassesMap class >> singleton: anObject [
	Singleton := anObject
]

{ #category : 'as yet unclassified' }
LuiCssClassesMap >> cssClassFor: aSymbol [
	^ self cssClassesMap at: aSymbol ifAbsentPut: aSymbol asString
]

{ #category : 'accessing' }
LuiCssClassesMap >> cssClassesMap [
	^ cssClassesMap
]

{ #category : 'accessing' }
LuiCssClassesMap >> cssClassesMap: anObject [
	cssClassesMap := anObject
]

{ #category : 'initialize' }
LuiCssClassesMap >> initialize [
	super initialize.
	self cssClassesMap: Dictionary new
]
