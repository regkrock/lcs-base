Class {
	#name : 'LuiFormInputComponent',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiFormInputComponent class >> isAbstract [ 
	^ self == LuiFormInputComponent
]

{ #category : 'attributes - accessing' }
LuiFormInputComponent >> callback [
	^ self attributes callback 
]

{ #category : 'attributes - accessing' }
LuiFormInputComponent >> callback: aBlock [
	self attributes callback: aBlock 
]

{ #category : 'initialize' }
LuiFormInputComponent >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'gt views' }
LuiFormInputComponent >> gtViewTagName [
	^'input'
]

{ #category : 'callbacks' }
LuiFormInputComponent >> handleCallbackValue: value [
	self valueAccessor write: (self convertFromString: value)
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeNamed: aName [
	super initializeNamed: aName.
	self callback: [ :value | self handleCallbackValue: value ]
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self callback: [ :value | self handleCallbackValue: value ]
]

{ #category : 'attributes' }
LuiFormInputComponent >> name [
	^ self attributes name
]

{ #category : 'attributes' }
LuiFormInputComponent >> name: aName [ 
	self attributes name: aName
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholderAttribute [
	^ self attributes placeholderAttribute
]
