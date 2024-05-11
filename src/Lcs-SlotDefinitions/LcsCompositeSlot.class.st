Class {
	#name : #LcsCompositeSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCompositeSlot >> initialValueFor: aDomainObject [
	^ (self initialValueBlock cull: aDomainObject)
		parent: aDomainObject;
		yourself
]

{ #category : #accessing }
LcsCompositeSlot >> initializeSlotValueIn: aDomainObject [
	self setValueTo: (self initialValueFor: aDomainObject) in: aDomainObject
]
