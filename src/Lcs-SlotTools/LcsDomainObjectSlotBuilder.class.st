Class {
	#name : #LcsDomainObjectSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#category : #'Lcs-SlotTools-Core'
}

{ #category : #configuration }
LcsDomainObjectSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsDomainObjectSlot
]
