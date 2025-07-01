Class {
	#name : #LcsScaledDecimalSlot,
	#superclass : #LcsNumberSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsScaledDecimalSlot >> defaultInitialValueBlock [ 
	^ [ 0 asScaledDecimal: self numberOfDecimals ]
]

{ #category : #initialize }
LcsScaledDecimalSlot >> initialize [
	super initialize.
	self numberOfDecimals: 2
]

{ #category : #properties }
LcsScaledDecimalSlot >> numberOfDecimals [
	^ self properties at: 'numberOfDecimals' ifAbsent: [ 2 ]
]

{ #category : #properties }
LcsScaledDecimalSlot >> numberOfDecimals: anObject [
	self properties at: 'numberOfDecimals' put: anObject
]

{ #category : #configuration }
LcsScaledDecimalSlot >> typeClass [
	^LcsSmalltalkConfiguration scaledDeciamlClass
]
