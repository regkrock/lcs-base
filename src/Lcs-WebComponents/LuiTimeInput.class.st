Class {
	#name : 'LuiTimeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''time'''
]

{ #category : 'initialize' }
LuiTimeInput >> initialize [
	super initialize.
	self toStringConverter: LuiTimeToStringConverter  new.
	self fromStringConverter: LuiStringToTimeConverter new
	
]

{ #category : 'rendering' }
LuiTimeInput >> renderComponentOn: html [
	html timeInput5
		addCommonAttributes: self;
		value: self displayValue
]
