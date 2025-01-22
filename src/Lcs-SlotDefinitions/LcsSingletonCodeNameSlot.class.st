Class {
	#name : #LcsSingletonCodeNameSlot,
	#superclass : #LcsCodeNameSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsSingletonCodeNameSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :domainClass | domainClass defaultCodeName ]
]
