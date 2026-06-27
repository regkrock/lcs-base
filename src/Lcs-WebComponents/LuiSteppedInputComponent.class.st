Class {
	#name : 'LuiSteppedInputComponent',
	#superclass : 'LuiAbstractTextAreaComponent',
	#instVars : [
		'fromStringConverter',
		'toStringConverter'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiSteppedInputComponent class >> isAbstract [ 
	^ self == LuiSteppedInputComponent
]

{ #category : 'initialize' }
LuiSteppedInputComponent >> componentAttributesClass [
	^ LuiSteppedInputAttributes
]

{ #category : 'callbacks' }
LuiSteppedInputComponent >> convertFromString: value [
	^ self fromStringConverter convertFromString: value
]

{ #category : 'accessing' }
LuiSteppedInputComponent >> fromStringConverter [
	^ fromStringConverter
]

{ #category : 'accessing' }
LuiSteppedInputComponent >> fromStringConverter: anObject [
	fromStringConverter := anObject
]

{ #category : 'attributes - accessing' }
LuiSteppedInputComponent >> max [
	^ self attributes max
]

{ #category : 'attributes - accessing' }
LuiSteppedInputComponent >> max: anInteger [
	self attributes max: anInteger
]

{ #category : 'attributes - accessing' }
LuiSteppedInputComponent >> min [
	^ self attributes min
]

{ #category : 'attributes - accessing' }
LuiSteppedInputComponent >> min: anInteger [
	self attributes min: anInteger
]

{ #category : 'attributes   - accessing' }
LuiSteppedInputComponent >> step [
	^ self attributes step
]

{ #category : 'attributes   - accessing' }
LuiSteppedInputComponent >> step: anInteger [
	self attributes step: anInteger
]

{ #category : 'accessing' }
LuiSteppedInputComponent >> toStringConverter [
	^ toStringConverter
]

{ #category : 'accessing' }
LuiSteppedInputComponent >> toStringConverter: anObject [
	toStringConverter := anObject
]
