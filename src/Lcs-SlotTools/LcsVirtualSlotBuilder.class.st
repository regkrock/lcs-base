Class {
	#name : #LcsVirtualSlotBuilder,
	#superclass : #LcsBaseSlotBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #con }
LcsVirtualSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsVirtualSlot
]
