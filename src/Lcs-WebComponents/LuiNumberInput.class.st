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

{ #category : 'initialize' }
LuiNumberInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self 
		step: aSlotDefinition stepValue;
		min: aSlotDefinition minimum;
		max: aSlotDefinition maximum
]

{ #category : 'rendering' }
LuiNumberInput >> renderComponentOn: html [
	html numberInput
		addCommonAttributes: self;
		value: self displayValue
]
