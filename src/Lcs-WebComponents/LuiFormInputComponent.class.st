Class {
	#name : 'LuiFormInputComponent',
	#superclass : 'LuiComponent',
	#instVars : [
		'valueAccessor'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiFormInputComponent class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition on: nil
]

{ #category : 'instance creation' }
LuiFormInputComponent class >> onSlot: aSlotDefinition on: aComponent [
	^ super new 
		initializeOnSlot: aSlotDefinition on: aComponent;
		yourself
]

{ #category : 'initialize' }
LuiFormInputComponent >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'initialize' }
LuiFormInputComponent >> initializeOnSlot: aSlotDefinition on: aComponent [ 
	self valueAccessor: (LuiSlotAccessor new).
	self valueAccessor slotDefinition: aSlotDefinition
		
]

{ #category : 'as yet unclassified' }
LuiFormInputComponent >> model [
	^ self valueAccessor model.
]

{ #category : 'as yet unclassified' }
LuiFormInputComponent >> model: aModel [
	self valueAccessor model: aModel.
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

{ #category : 'accessing' }
LuiFormInputComponent >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiFormInputComponent >> valueAccessor: anObject [
	valueAccessor := anObject
]
