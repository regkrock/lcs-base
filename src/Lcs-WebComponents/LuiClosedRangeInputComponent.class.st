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
