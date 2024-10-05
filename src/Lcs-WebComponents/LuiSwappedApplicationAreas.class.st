Class {
	#name : #LuiSwappedApplicationAreas,
	#superclass : #LuiComponent,
	#instVars : [
		'swappedOutComponents'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiSwappedApplicationAreas >> initialize [ 
	super initialize.
	self swappedOutComponents: OrderedCollection new
]

{ #category : #api }
LuiSwappedApplicationAreas >> swappedOut: aComponent [
	(self swappedOutComponents includes: aComponent)
		ifFalse: [ self swappedOutComponents add: aComponent ]
]

{ #category : #accessing }
LuiSwappedApplicationAreas >> swappedOutComponents [
	^ swappedOutComponents
]

{ #category : #accessing }
LuiSwappedApplicationAreas >> swappedOutComponents: anObject [
	swappedOutComponents := anObject
]
