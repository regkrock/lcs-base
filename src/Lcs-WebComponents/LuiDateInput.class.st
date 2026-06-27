Class {
	#name : 'LuiDateInput',
	#superclass : 'LuiClosedRangeInputComponent',
	#instVars : [
		'date'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateInput >> contentsAsString [
	^ self toStringConverter convertToString: self valueAccessor contents
]

{ #category : 'rendering' }
LuiDateInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'gt views' }
LuiDateInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''date'''
]

{ #category : 'callbacks' }
LuiDateInput >> handleCallbackValue: value [ 
	self valueAccessor write: (Date readFrom: value pattern: 'y-m-d')
]

{ #category : 'initialize' }
LuiDateInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateToStringConverter new.
	self fromStringConverter: LuiStringToDateConverter new.
]

{ #category : 'rendering' }
LuiDateInput >> renderComponentOn: html [
	html dateInput5
		addCommonAttributes: self;
		"onChange: (JSStream on: 'this.form.requestSubmit()');"
		"onChange: 'submit()';"
		"callback: [ :value | self updateContentsFrom: value ];"
		"callback: (GRDelayedSend 
					receiver: self
					selector: #updateContentsFrom:);"
		value: self contentsAsString
]
