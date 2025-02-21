"
This is the superclass of all non-system module classes.
"
Class {
	#name : #LcsModule,
	#superclass : #LcsBaseModule,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'as yet unclassified' }
LcsModule >> parentSlotDefinition [
	^ LcsParentSlot new
]
