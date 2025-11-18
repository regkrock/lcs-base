Class {
	#name : #LcsSingletonCodeDescriptionSlot,
	#superclass : #LcsDescriptionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeDescriptionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultDescription ]
]
