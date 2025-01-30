Class {
	#name : #LcsDirectAssignmentSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsDirectAssignmentSlot >> _slotVarPut: anObject in: aDomainObject [ 
	self verifyType: anObject.
	aDomainObject instVarNamed: self slotName put: anObject
]

{ #category : #'as yet unclassified' }
LcsDirectAssignmentSlot >> initialValueFor: aDomainObject [
	| newValue |
	newValue := self initialValueBlock cull: aDomainObject.
	"Bypassing unit of work"
	"(newValue isDomainObject and: [ self currentSystem notNil ])
		ifNotNil: [ self currentUnitOfWork addObject: newValue context: aDomainObject ]."
	^newValue
]
