Class {
	#name : #LcsCountrySubdivisionClassSlot,
	#superclass : #LcsDomainClassSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCountrySubdivisionClassSlot >> initialize [
	super initialize.
	self slotName: 'subdivisionClass'.
	self superclassClass:  LcsBaseCountrySubdivision.
	self initialValue: LcsCountrySubdivision.
	self superclassClass subclassesDo: [ :eachClass | self addSlotType: eachClass ]

]
