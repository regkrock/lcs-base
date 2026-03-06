Class {
	#name : 'LcsNumberSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsNumberSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | 0 ]
]

{ #category : 'defaults' }
LcsNumberSlot >> typeClass [
	^ Number
]
