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

{ #category : 'rendering' }
LuiRangeInput >> renderComponentOn: html [
	html rangeInput
		addCommonAttributes: self;
		value: self displayValue
]
