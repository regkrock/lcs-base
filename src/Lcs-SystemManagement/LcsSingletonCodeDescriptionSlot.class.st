Class {
	#name : #LcsSingletonCodeDescriptionSlot,
	#superclass : #LcsCodeDescriptionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonCodeDescriptionSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :domainClass | domainClass defaultCodeDescription ]
]
