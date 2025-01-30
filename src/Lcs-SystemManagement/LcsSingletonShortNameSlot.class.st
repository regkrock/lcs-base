Class {
	#name : #LcsSingletonShortNameSlot,
	#superclass : #LcsShortNameSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialialize }
LcsSingletonShortNameSlot >> initialize [
	super initialize.
	self initialValueBlock: [ :domainClass | domainClass defaultShortName ]
]
