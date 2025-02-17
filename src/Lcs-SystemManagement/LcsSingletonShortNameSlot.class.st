Class {
	#name : #LcsSingletonShortNameSlot,
	#superclass : #LcsShortNameSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonShortNameSlot >> initialize [
	super initialize.
	self initialValueBlock: [ :domainClass | domainClass defaultShortName ]
]
