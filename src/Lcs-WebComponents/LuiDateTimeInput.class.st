Class {
	#name : 'LuiDateTimeInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'date'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateTimeInput >> contentsAsString [
	^ self toStringConverter convertToString:  self valueAccessor contents
]

{ #category : 'rendering' }
LuiDateTimeInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'gt views' }
LuiDateTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime'''
]

{ #category : 'callbacks' }
LuiDateTimeInput >> handleCallbackValue: value [ 
	self valueAccessor write: (self fromStringConverter convertFromString: value)
]

{ #category : 'initialize' }
LuiDateTimeInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateAndTimeToStringConverter new.
	self fromStringConverter: LuiStringToDateAndTimeConverter new.
]

{ #category : 'rendering' }
LuiDateTimeInput >> renderComponentOn: html [
	html dateTimeInput
		addCommonAttributes: self;
		"onChange: (JSStream on: 'this.form.requestSubmit()');"
		"onChange: 'submit()';"
		"callback: [ :value | self updateContentsFrom: value ];"
		"callback: (GRDelayedSend 
					receiver: self
					selector: #updateContentsFrom:);"
		value: self contentsAsString
]
