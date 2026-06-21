Class {
	#name : 'LuiSteppedInputComponent',
	#superclass : 'LuiAbstractTextAreaComponent',
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

{ #category : 'attributes   - accessing' }
LuiSteppedInputComponent >> step [
	^ self attributes step
]

{ #category : 'attributes   - accessing' }
LuiSteppedInputComponent >> step: anInteger [
	self attributes step: anInteger
]
