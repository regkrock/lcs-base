Class {
	#name : #LcsNumberSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #accessing }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ 0 ]
]

{ #category : #default }
LcsNumberSlot >> typeClass [
	^ Number
]
