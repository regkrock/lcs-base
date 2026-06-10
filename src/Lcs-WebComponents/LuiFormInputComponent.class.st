Class {
	#name : 'LuiFormInputComponent',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiFormInputComponent >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeNamed: aName [
	super initializeNamed: aName.
	self name: aName.
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeOnSlot: aSlotDefinition model: aModel [
	super initializeOnSlot: aSlotDefinition model: aModel .
	self name: aSlotDefinition slotName
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
LuiFormInputComponent >> placeholder [
	^ self placeholderAttribute placeholder
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholder: aString [
	^ self placeholderAttribute placeholder: aString
]

{ #category : 'attributes' }
LuiFormInputComponent >> placeholderAttribute [
	^ self attributes placeholderAttribute
]
