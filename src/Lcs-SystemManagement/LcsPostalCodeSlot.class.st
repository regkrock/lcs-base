Class {
	#name : 'LcsPostalCodeSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsPostalCodeSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | parentDomainObject country postalCodeClass new ]
]

{ #category : 'initialize' }
LcsPostalCodeSlot >> initialize [
	super initialize.
	self slotName: 'postalCode'.
	self addSubclassesOf: LcsBasePostCode.
	self priority: 18.
	self required: true
]

{ #category : 'slot model' }
LcsPostalCodeSlot >> slotVarPut: anObject in: aDomainObject [
	anObject slotVarNamed: 'parent' put: aDomainObject.
	super slotVarPut: anObject in: aDomainObject
]
