Class {
	#name : #LcsCompositeSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCompositeSlot >> initializeSlotValueIn: aDomainObject [
	self
		setValueTo: (self newSlotValue
				parent: aDomainObject;
				yourself)
		in: aDomainObject
]
