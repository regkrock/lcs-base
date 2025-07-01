Class {
	#name : #LcsParentSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsParentSlot >> initialize [
	super initialize.
	self 
		slotName: 'parent';
		addSlotType: LcsBaseDomainObject.
]

{ #category : #'slot model' }
LcsParentSlot >> initializeSlotValueIn: aDomainObject [
]

{ #category : #'slot model' }
LcsParentSlot >> persistValue: aDomainObject  contextObject: aDomainCreationContext [
	aDomainObject instVarNamed: self slotName put: aDomainCreationContext
]
