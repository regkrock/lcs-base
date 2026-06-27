Class {
	#name : 'LuiDateTimeLocalInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'date'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateTimeLocalInput >> contentsAsString [
	^ self toStringConverter convertToString: self valueAccessor contents
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'gt views' }
LuiDateTimeLocalInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime-local'''
]

{ #category : 'callbacks' }
LuiDateTimeLocalInput >> handleCallbackValue: value [ 
	self valueAccessor write: (self fromStringConverter convertFromString: value)
]

{ #category : 'initialize' }
LuiDateTimeLocalInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateAndTimeToStringConverter new.
	self fromStringConverter: LuiStringToDateAndTimeConverter new.
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> renderComponentOn: html [
	html dateTimeLocalInput
		addCommonAttributes: self;
		"onChange: (JSStream on: 'this.form.requestSubmit()');"
		"onChange: 'submit()';"
		"callback: [ :value | self updateContentsFrom: value ];"
		"callback: (GRDelayedSend 
					receiver: self
					selector: #updateContentsFrom:);"
		value: self contentsAsString
]
