Class {
	#name : #LuiInputComponent,
	#superclass : #LuiComponent,
	#instVars : [
		'valueAccessor'
	],
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #initialize }
LuiInputComponent >> initializeNamed: aName on: aWebComponent [
	super initializeNamed: aName on: aWebComponent.
	self valueAccessor: (LuiSlotAccessor new)
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
