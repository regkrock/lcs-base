Class {
	#name : #LcsParentSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #accessing }
LcsParentSlot >> initialize [
	super initialize.
	self 
		slotName: 'parent';
		addSlotType: LcsDomainObject.
]

{ #category : #accessing }
LcsParentSlot >> initializeSlotValueIn: aDomainObject [
	"Do nothing - this will be set by its parent"
]

{ #category : #accessing }
LcsParentSlot >> persistValue: aDomainObject  contextObject: aDomainCreationContext [
	aDomainObject instVarNamed: self slotName put: aDomainCreationContext
]
