Class {
	#name : 'LcsNumberSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#traits : 'LtRangeRule',
	#classTraits : 'LtRangeRule classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | 0 ]
]

{ #category : 'defaults' }
LcsNumberSlot >> defaultStepValue [
	^ nil
]

{ #category : 'initialize' }
LcsNumberSlot >> initialize [
	super initialize.
	self stepValue: self defaultStepValue
]

{ #category : 'properties' }
LcsNumberSlot >> stepValue [
	^ self propertyAt: #stepValue
]

{ #category : 'properties' }
LcsNumberSlot >> stepValue: aNumber [
	self propertyAt: #'stepValue' put: aNumber
]

{ #category : 'defaults' }
LcsNumberSlot >> typeClass [
	^ Number
]
