Class {
	#name : 'LcsSingletonValueCodeNameSlot',
	#superclass : 'LcsValueCodeSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSingletonValueCodeNameSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultCode ]
]
