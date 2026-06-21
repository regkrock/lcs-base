Class {
	#name : 'LuiDateTimeLocalInput',
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
LuiDateTimeLocalInput >> contentsAsString [
	^ self toStringConverter value: self valueAccessor contents
]

{ #category : 'converting' }
LuiDateTimeLocalInput >> contentsFromString: aString [
	^ self fromStringConverter value: aString
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'accessing' }
LuiDateTimeLocalInput >> fromStringConverter [
	^ fromStringConverter
]

{ #category : 'accessing' }
LuiDateTimeLocalInput >> fromStringConverter: anObject [
	fromStringConverter := anObject
]

{ #category : 'gt views' }
LuiDateTimeLocalInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''datetime-local'''
]

{ #category : 'callbacks' }
LuiDateTimeLocalInput >> handleCallbackValue: value [ 
	self valueAccessor write: (Date readFrom: value pattern: 'y-m-d')
]

{ #category : 'initialize' }
LuiDateTimeLocalInput >> initialize [
	super initialize.
	self toStringConverter: LuiDateToStringConverter new.
	self fromStringConverter: LuiStringToDateConverter new.
]

{ #category : 'initialize' }
LuiDateTimeLocalInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self attributes name: aSlotDefinition slotName
]

{ #category : 'rendering' }
LuiDateTimeLocalInput >> renderComponentOn: html [
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
LuiDateTimeLocalInput >> toStringConverter [
	^ toStringConverter
]

{ #category : 'accessing' }
LuiDateTimeLocalInput >> toStringConverter: anObject [
	toStringConverter := anObject
]

{ #category : 'model' }
LuiDateTimeLocalInput >> updateContentsFrom: value [
	^ self valueAccessor write: (self contentsFromString: value)
]
