Class {
	#name : 'LcsSingletonCodeDescriptionSlot',
	#superclass : 'LcsDescriptionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSingletonCodeDescriptionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultDescription ]
]
