Class {
	#name : #LcsDirectAssignmentSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsDirectAssignmentSlot >> _slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject for: nil.
	aDomainObject instVarNamed: self slotName put: anObject
]

{ #category : #defaults }
LcsDirectAssignmentSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | | newValue |
		newValue := self slotTypes any new.
		newValue isDomainObject ifTrue: [
			newValue parent: parentDomainObject ].
		newValue ]
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
