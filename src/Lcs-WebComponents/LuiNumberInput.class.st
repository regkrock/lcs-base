Class {
	#name : 'LuiNumberInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiNumberInput >> displayValue [
	self valueAccessor ifNil: [ ^ '' ].
	^ self toStringConverter convertToString: valueAccessor read
]

{ #category : 'gt views' }
LuiNumberInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''number'''
]

{ #category : 'callbacks' }
LuiNumberInput >> handleCallbackValue: aValue [ 
	"| number |
	number := self fromStringConverter convertFromString: aValue."
	super handleCallbackValue: aValue 
]

{ #category : 'initialize' }
LuiNumberInput >> initialize [
	super initialize.
	self fromStringConverter: LuiNumberStringConverter new.
	self toStringConverter: LuiNumberStringConverter new.
]

{ #category : 'rendering' }
LuiNumberInput >> renderComponentOn: html [
	html numberInput
		addCommonAttributes: self;
		value: self displayValue
]
