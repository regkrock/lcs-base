Class {
	#name : 'LuiClosedRangeInputComponent',
	#superclass : 'LuiSteppedInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiClosedRangeInputComponent class >> isAbstract [ 
	^ self == LuiClosedRangeInputComponent
]

{ #category : 'initialize' }
LuiClosedRangeInputComponent >> componentAttributesClass [
	^ LuiClosedRangeInputAttributes
]

{ #category : 'attributes - accessing' }
LuiClosedRangeInputComponent >> max [
	^ self attributes max
]

{ #category : 'attributes - accessing' }
LuiClosedRangeInputComponent >> max: anInteger [
	self attributes max: anInteger
]

{ #category : 'attributes - accessing' }
LuiClosedRangeInputComponent >> min [
	^ self attributes min
]

{ #category : 'attributes - accessing' }
LuiClosedRangeInputComponent >> min: anInteger [
	self attributes min: anInteger
	"attributeAt: 'min' put: anInteger"
]
