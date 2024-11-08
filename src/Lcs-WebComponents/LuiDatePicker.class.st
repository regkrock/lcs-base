Class {
	#name : #LuiDatePicker,
	#superclass : #LuiInputComponent,
	#instVars : [
		'date',
		'fromStringConverter',
		'toStringConverter'
	],
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #converting }
LuiDatePicker >> contentsAsString [
	^ self toStringConverter value: self valueAccessor contents
]

{ #category : #converting }
LuiDatePicker >> contentsFromString: aString [
	^ self fromStringConverter value: aString
]

{ #category : #rendering }
LuiDatePicker >> displayValue [
	^ self valueAccessor displayValue yyyymmdd
]

{ #category : #accessing }
LuiDatePicker >> fromStringConverter [
	^ fromStringConverter
]

{ #category : #accessing }
LuiDatePicker >> fromStringConverter: anObject [
	fromStringConverter := anObject
]

{ #category : #initialize }
LuiDatePicker >> initialize [
	super initialize.
	self toStringConverter: LuiDateToStringConverter new.
	self fromStringConverter: LuiStringToDateConverter new.
]

{ #category : #initialize }
LuiDatePicker >> initializeOnSlot: aSlotDefinition on: aComponent [ 
	super initializeOnSlot: aSlotDefinition on: aComponent .
	self properties name: aSlotDefinition slotName
]

{ #category : #rendering }
LuiDatePicker >> renderComponentOn: html [
	html dateInput5
		addCommonProperties: self;
		onChange: (JSStream on: 'this.form.requestSubmit()');
		"onChange: 'submit()';"
		"callback: [ :value | self updateContentsFrom: value ];"
		callback: (GRDelayedSend 
					receiver: self
					selector: #updateContentsFrom:);
		value: self contentsAsString
]

{ #category : #accessing }
LuiDatePicker >> toStringConverter [
	^ toStringConverter
]

{ #category : #accessing }
LuiDatePicker >> toStringConverter: anObject [
	toStringConverter := anObject
]

{ #category : #model }
LuiDatePicker >> updateContentsFrom: value [
	^ self valueAccessor write: (self contentsFromString: value)
]
