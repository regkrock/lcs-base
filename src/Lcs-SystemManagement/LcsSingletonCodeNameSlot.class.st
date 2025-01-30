Class {
	#name : #LcsSingletonCodeNameSlot,
	#superclass : #LcsCodeNameSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeNameSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :domainClass | domainClass defaultCodeName ]
]
