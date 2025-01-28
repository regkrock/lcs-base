Class {
	#name : #LcsFacadeSlot,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'targetSlotName',
		'convertFromTarget',
		'convertToTarget'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #accessing }
LcsFacadeSlot >> convertFromTarget [
	^ convertFromTarget
]

{ #category : #accessing }
LcsFacadeSlot >> convertFromTarget: anObject [
	convertFromTarget := anObject
]

{ #category : #accessing }
LcsFacadeSlot >> convertToTarget [
	^ convertToTarget
]

{ #category : #accessing }
LcsFacadeSlot >> convertToTarget: anObject [
	convertToTarget := anObject
]

{ #category : #'as yet unclassified' }
LcsFacadeSlot >> currentSlotVarIn: aDomainObject [
	^ self convertFromTarget 
		cull: (aDomainObject perform: #slotVarNamed: with: self targetSlotName) 
		cull: aDomainObject
]

{ #category : #'as yet unclassified' }
LcsFacadeSlot >> currentSlotVarIn: aDomainObject put: anObject [
	aDomainObject perform: #slotVarNamed:put: 
		with: self targetSlotName
		with: (self convertToTarget cull: anObject cull: aDomainObject)
]

{ #category : #accessing }
LcsFacadeSlot >> targetSlotName [
	^ targetSlotName
]

{ #category : #accessing }
LcsFacadeSlot >> targetSlotName: anObject [
	targetSlotName := anObject
]
