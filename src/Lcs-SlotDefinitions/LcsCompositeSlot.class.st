Class {
	#name : #LcsCompositeSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCompositeSlot >> initializeModel: aDomainObject [
	| componentObject |
	componentObject := self newSlotValue.
	componentObject parent: aDomainObject.
	self setValueTo: componentObject in: aDomainObject
	
	"super initializeModel: aDomainObject"
]
