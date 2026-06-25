Class {
	#name : 'LcsSmallIntegerSlot',
	#superclass : 'LcsIntegerSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'configuration' }
LcsSmallIntegerSlot >> typeClass [
	^ LcsSmalltalkConfiguration smallIntegerClass 
]
