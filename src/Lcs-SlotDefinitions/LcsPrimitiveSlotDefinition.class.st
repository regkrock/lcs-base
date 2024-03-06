Class {
	#name : #LcsPrimitiveSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsPrimitiveSlotDefinition >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #accessing }
LcsPrimitiveSlotDefinition >> typeClass [
	^ self subclassResponsibility
]
