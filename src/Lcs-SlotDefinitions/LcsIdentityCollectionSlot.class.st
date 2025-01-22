Class {
	#name : #LcsIdentityCollectionSlot,
	#superclass : #LcsCollectionSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #iniitialize }
LcsIdentityCollectionSlot >> typeClass [
	^ IdentitySet 
]
