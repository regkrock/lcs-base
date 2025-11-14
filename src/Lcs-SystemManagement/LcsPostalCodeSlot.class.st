Class {
	#name : #LcsPostalCodeSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsPostalCodeSlot >> initialize [
	super initialize.
	self slotName: 'postalCode'.
	self addSubclassesOf: LcsBasePostCode.
	self initialValueBlock: [ :domainObject :slot | domainObject country postalCodeClass new ].
	self priority: 18.
	self required: true
]

{ #category : #'slot model' }
LcsPostalCodeSlot >> slotVarPut: anObject in: aDomainObject [
	anObject slotVarNamed: 'parent' put: aDomainObject.
	super slotVarPut: anObject in: aDomainObject
]
