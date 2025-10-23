Class {
	#name : #LcsDelegatorSlot,
	#superclass : #LcsFacadeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot access' }
LcsDelegatorSlot >> currentSlotVarIn: aTargetDomainObject [
	| actualDomainObject |
	actualDomainObject := aTargetDomainObject.
	self targetSlotPath
		do: [ :each | actualDomainObject := actualDomainObject perform: each asSymbol ].
	^ actualDomainObject
]

{ #category : #initialize }
LcsDelegatorSlot >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new
]

{ #category : #'slot access' }
LcsDelegatorSlot >> slotVarPut: anObject in: aTargetDomainObject [
	| actualDomainObject |
	actualDomainObject := aTargetDomainObject.
	(self targetSlotPath copyFrom: 1 to: (self targetSlotPath size - 1)) do: [ :each |
		actualDomainObject := actualDomainObject perform: each asSymbol ].
	actualDomainObject
		slotVarNamed: self targetSlotPath last
		put: anObject
]

{ #category : #properties }
LcsDelegatorSlot >> targetSlotPath [
	^ self properties at: 'targetSlotPath'
]

{ #category : #properties }
LcsDelegatorSlot >> targetSlotPath: aSlotNamesCollection [ 
	self properties at: 'targetSlotPath' put: aSlotNamesCollection asOrderedCollection
]
