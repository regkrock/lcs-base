Class {
	#name : #LcsIdentityCollectionSlot,
	#superclass : #LcsCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #iniitialize }
LcsIdentityCollectionSlot >> typeClass [
	^ IdentitySet 
]
