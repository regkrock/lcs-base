Class {
	#name : #LcsBlockSlotDefinition,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsBlockSlotDefinition >> defaultInitialValueBlock [
	^ nil
]

{ #category : #'as yet unclassified' }
LcsBlockSlotDefinition >> initialValueFor: aDomainObject [
	^ self initialValueBlock 
		ifNil: [ [ true ] ] 
		ifNotNil: [ self initialValueBlock ]
]

{ #category : #initialize }
LcsBlockSlotDefinition >> typeClass [
	^ BlockClosure.
]
