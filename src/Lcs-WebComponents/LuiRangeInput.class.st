Class {
	#name : 'LuiRangeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiRangeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''range'''
]

{ #category : 'as yet unclassified' }
LuiRangeInput >> initialize [
	super initialize.
	self fromStringConverter: LuiNumberStringConverter new.
	self toStringConverter: LuiNumberStringConverter new
]

{ #category : 'initialize' }
LuiRangeInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self 
		step: aSlotDefinition stepValue;
		min: aSlotDefinition minimum;
		max: aSlotDefinition maximum
]

{ #category : 'rendering' }
LuiRangeInput >> renderComponentOn: html [
	html rangeInput
		addCommonAttributes: self;
		value: self displayValue
]
