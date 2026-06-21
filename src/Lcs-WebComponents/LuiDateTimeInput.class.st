Class {
	#name : 'LuiDateTimeInput',
	#superclass : 'LuiSteppedInputComponent',
	#instVars : [
		'date',
		'fromStringConverter',
		'toStringConverter'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'converting' }
LuiDateTimeInput >> contentsAsString [
	^ self toStringConverter value: self valueAccessor contents
]

{ #category : 'converting' }
LuiDateTimeInput >> contentsFromString: aString [
	^ self fromStringConverter value: aString
]

{ #category : 'rendering' }
LuiDateTimeInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'accessing' }
LuiDateTimeInput >> fromStringConverter [
	^ fromStringConverter
]

{ #category : 'accessing' }
LuiDateTimeInput >> fromStringConverter: anObject [
	fromStringConverter := anObject
]

{ #category : 'gt views' }
LuiDateTimeInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime'''
]

{ #category : 'callbacks' }
LuiDateTimeInput >> handleCallbackValue: value [ 
	self valueAccessor write: (Date readFrom: value pattern: 'y-m-d')
]

{ #category : 'initialize' }
LuiDateTimeInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateToStringConverter new.
	self fromStringConverter: LuiStringToDateConverter new.
]

{ #category : 'initialize' }
LuiDateTimeInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self attributes name: aSlotDefinition slotName
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

{ #category : 'accessing' }
LuiDateTimeInput >> toStringConverter [
	^ toStringConverter
]

{ #category : 'accessing' }
LuiDateTimeInput >> toStringConverter: anObject [
	toStringConverter := anObject
]

{ #category : 'model' }
LuiDateTimeInput >> updateContentsFrom: value [
	^ self valueAccessor write: (self contentsFromString: value)
]
