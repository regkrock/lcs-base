Class {
	#name : #LcsCompositeSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCompositeSlotDefinition >> initializeModel: aDomainObject [
	| componentObject |
	componentObject := self newSlotValue.
	componentObject parent: aDomainObject.
	self setValueTo: componentObject in: aDomainObject
	
	"super initializeModel: aDomainObject"
]
