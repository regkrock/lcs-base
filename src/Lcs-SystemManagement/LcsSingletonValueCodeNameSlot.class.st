Class {
	#name : #LcsSingletonValueCodeNameSlot,
	#superclass : #LcsValueCodeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonValueCodeNameSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultCode ]
]
