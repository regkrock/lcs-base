Class {
	#name : #LcsDomainClassSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'domainClass'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsDomainClassSlot >> domainClass1 [
	^ domainClass
]

{ #category : #accessing }
LcsDomainClassSlot >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #'slot model' }
LcsDomainClassSlot >> initializeModel: aDomainObject [
	self
		setValueTo: (self newSlotValue
				parent: aDomainObject;
				yourself)
		in: aDomainObject
]
