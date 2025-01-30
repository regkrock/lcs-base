Class {
	#name : #LcsVirtualSlotDefinition,
	#superclass : #LcsBaseSlotDefinition,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsVirtualSlotDefinition >> _slotVarPut: anObject in: aDomainObject [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
LcsVirtualSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	self error: 'This is a read only slot'
]
