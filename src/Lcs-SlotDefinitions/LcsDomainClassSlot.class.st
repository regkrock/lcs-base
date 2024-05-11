Class {
	#name : #LcsDomainClassSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot model' }
LcsDomainClassSlot >> initialValueFor: aDomainObject [
	^ (self initialValueBlock cull: aDomainObject)
		parent: aDomainObject;
		yourself
]

{ #category : #'slot model' }
LcsDomainClassSlot >> initializeSlotValueIn: aDomainObject [
	self setValueTo: (self initialValueFor: aDomainObject) in: aDomainObject
]
