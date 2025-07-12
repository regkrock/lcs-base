Class {
	#name : #LcsScaledDecimalSlot,
	#superclass : #LcsNumberSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsScaledDecimalSlot >> defaultInitialValueBlock [ 
	^ [ :domainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]
]

{ #category : #initialize }
LcsScaledDecimalSlot >> defaultNumberOfDecimals [
	^ 2
]

{ #category : #initialize }
LcsScaledDecimalSlot >> initialize [
	super initialize.
	self numberOfDecimals: self defaultNumberOfDecimals
]

{ #category : #properties }
LcsScaledDecimalSlot >> numberOfDecimals [
	^ self propertyAt: 'numberOfDecimals' ifAbsent: [ 2 ]
]

{ #category : #properties }
LcsScaledDecimalSlot >> numberOfDecimals: anObject [
	self propertyAt: 'numberOfDecimals' put: anObject
]

{ #category : #initialize }
LcsScaledDecimalSlot >> prevalidationTransformBlock [
	^ [ :value :slot | 
			value isNumber ifTrue: [ value asScaledDecimal: slot numberOfDecimals ] ifFalse: [ value ] ]
]

{ #category : #configuration }
LcsScaledDecimalSlot >> typeClass [
	^LcsSmalltalkConfiguration scaledDeciamlClass
]
