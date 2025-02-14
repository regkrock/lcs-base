Class {
	#name : #LcsParentSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsParentSlot >> initialize [
	super initialize.
	self 
		slotName: 'parent';
		addSlotType: LcsBaseDomainObject.
]

{ #category : #accessing }
LcsParentSlot >> initializeSlotValueIn: aDomainObject [
	"Do nothing - this will be set by its parent"
]

{ #category : #accessing }
LcsParentSlot >> persistValue: aDomainObject  contextObject: aDomainCreationContext [
	aDomainObject instVarNamed: self slotName put: aDomainCreationContext
]
