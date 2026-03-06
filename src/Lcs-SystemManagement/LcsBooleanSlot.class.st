Class {
	#name : 'LcsBooleanSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsBooleanSlot >> defaultInitialValueBlock [ 
	^ [ :parentDomainObject :slot | false ]
]

{ #category : 'configuration' }
LcsBooleanSlot >> typeClass [
	^ LcsSmalltalkConfiguration booleanClass
]
