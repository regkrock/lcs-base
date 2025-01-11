Class {
	#name : #LcsBlockSlotDefinition,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsBlockSlotDefinition >> defaultInitialValueBlock [
	^ nil
]

{ #category : #'as yet unclassified' }
LcsBlockSlotDefinition >> initialValueFor: aDomainObject [
	^ self initialValueBlock 
		ifNil: [ [ ] ] 
		ifNotNil: [ self initialValueBlock ]
]

{ #category : #initialize }
LcsBlockSlotDefinition >> typeClass [
	^ BlockClosure.
]
