Class {
	#name : #LcsSingletonLabelSlot,
	#superclass : #LcsLabelSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonLabelSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultLabel ]
]
