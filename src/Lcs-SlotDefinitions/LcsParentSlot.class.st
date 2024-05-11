Class {
	#name : #LcsParentSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsParentSlot >> initialize [
	super initialize.
	self slotName: 'parent'.
]

{ #category : #accessing }
LcsParentSlot >> initializeSlotValueIn: aDomainObject [
	"Do nothing - this will be set by its parent"
]
