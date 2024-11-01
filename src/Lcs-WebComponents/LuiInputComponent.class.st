Class {
	#name : #LuiInputComponent,
	#superclass : #LuiComponent,
	#instVars : [
		'valueAccessor'
	],
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #'instance creation' }
LuiInputComponent class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition on: nil
]

{ #category : #'instance creation' }
LuiInputComponent class >> onSlot: aSlotDefinition on: aComponent [
	^ super new 
		initializeOnSlot: aSlotDefinition on: aComponent;
		yourself
]

{ #category : #initialize }
LuiInputComponent >> initializeNamed: aName on: aWebComponent [
	super initializeNamed: aName on: aWebComponent.
	self valueAccessor: (LuiSlotAccessor new)
]

{ #category : #initialize }
LuiInputComponent >> initializeOnSlot: aSlotDefinition on: aComponent [ 
	self valueAccessor: (LuiSlotAccessor new).
	self valueAccessor slotDefinition: aSlotDefinition
		
]

{ #category : #'as yet unclassified' }
LuiInputComponent >> model: aModel [
	self valueAccessor model: aModel.
]

{ #category : #rendering }
LuiInputComponent >> renderComponentOn: html [

]

{ #category : #accessing }
LuiInputComponent >> valueAccessor [
	^ valueAccessor
]

{ #category : #accessing }
LuiInputComponent >> valueAccessor: anObject [
	valueAccessor := anObject
]
