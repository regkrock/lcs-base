Class {
	#name : 'LcsPostalCodeClassSlot',
	#superclass : 'LcsDomainClassSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsPostalCodeClassSlot >> initialize [
	super initialize.
	self slotName: 'postalCodeClass'.
	self superclassClass: LcsBasePostCode.
	self initialValue: LcsGenericPostalCode.
	self superclassClass subclassesDo: [ :eachClass | self addSlotType: eachClass ]
]
