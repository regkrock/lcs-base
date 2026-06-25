Class {
	#name : 'LuiNumberInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'converter'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'accessing' }
LuiNumberInput >> converter [
	^ converter
]

{ #category : 'accessing' }
LuiNumberInput >> converter: anObject [
	converter := anObject
]

{ #category : 'rendering' }
LuiNumberInput >> displayValue [
	self valueAccessor ifNil: [ ^ '' ].
	^ self converter convertToString: valueAccessor read
]

{ #category : 'gt views' }
LuiNumberInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''number'''
]

{ #category : 'callbacks' }
LuiNumberInput >> handleCallbackValue: aValue [ 
	| number |
	number := self converter convertFromString: aValue.
	super handleCallbackValue: number 
]

{ #category : 'initialize' }
LuiNumberInput >> initialize [
	super initialize.
	self converter: LuiNumberStringConverter new.
]

{ #category : 'rendering' }
LuiNumberInput >> renderComponentOn: html [
	html numberInput
		addCommonAttributes: self;
		value: self displayValue
]
