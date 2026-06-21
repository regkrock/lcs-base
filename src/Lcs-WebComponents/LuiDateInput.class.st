Class {
	#name : 'LuiDateInput',
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
LuiDateInput >> contentsAsString [
	^ self toStringConverter value: self valueAccessor contents
]

{ #category : 'converting' }
LuiDateInput >> contentsFromString: aString [
	^ self fromStringConverter value: aString
]

{ #category : 'rendering' }
LuiDateInput >> displayValue [
	^ self valueAccessor contents yyyymmdd
]

{ #category : 'accessing' }
LuiDateInput >> fromStringConverter [
	^ fromStringConverter
]

{ #category : 'accessing' }
LuiDateInput >> fromStringConverter: anObject [
	fromStringConverter := anObject
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

{ #category : 'initialize' }
LuiDateInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self attributes name: aSlotDefinition slotName
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

{ #category : 'accessing' }
LuiDateInput >> toStringConverter [
	^ toStringConverter
]

{ #category : 'accessing' }
LuiDateInput >> toStringConverter: anObject [
	toStringConverter := anObject
]

{ #category : 'model' }
LuiDateInput >> updateContentsFrom: value [
	^ self valueAccessor write: (self contentsFromString: value)
]
