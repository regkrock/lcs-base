Class {
	#name : 'LcsDomainObjectSlotBuilder',
	#superclass : 'LcsAccessorSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsDomainObjectSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsDomainObjectSlot
]
