Class {
	#name : #LcsDomainClassSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot model' }
LcsDomainClassSlot >> initializeSlotValueIn: aDomainObject [
	self
		setValueTo: (self newSlotValue
				parent: aDomainObject;
				yourself)
		in: aDomainObject
]
