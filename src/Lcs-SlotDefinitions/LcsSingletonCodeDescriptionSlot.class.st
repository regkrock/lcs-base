Class {
	#name : #LcsSingletonCodeDescriptionSlot,
	#superclass : #LcsCodeDescriptionSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsSingletonCodeDescriptionSlot >> initialize [
	super initialize.
	self 
		initialValueBlock: [ :domainClass | domainClass defaultCodeDescription ]
]
