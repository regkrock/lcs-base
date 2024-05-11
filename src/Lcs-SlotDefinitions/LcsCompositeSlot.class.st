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
