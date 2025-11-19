Class {
	#name : 'LcsSingletonLabelSlot',
	#superclass : 'LcsLabelSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSingletonLabelSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultLabel ]
]
