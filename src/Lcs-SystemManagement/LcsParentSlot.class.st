Class {
	#name : 'LcsParentSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsParentSlot class >> defaultSlotComment [
	^ 'This defines the slot in the ''child'' domain object which holds the backward refence to its ''owner'', the parent domain object. It is set when a new instance of the domain object is added to the unit of work.'
]

{ #category : 'initialize' }
LcsParentSlot >> initialize [
	super initialize.
	self
		slotName: 'parent';
		addSlotType: LcsBaseDomainObject;
		comment: self defaultSlotComment
]

{ #category : 'slot model' }
LcsParentSlot >> initializeSlotValueIn: aDomainObject [
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	LcsLogger logIndented: 'initialization deferred until added to unit of work'
]

{ #category : 'slot model' }
LcsParentSlot >> persistValue: aDomainObject  contextObject: aDomainCreationContext [
	aDomainObject instVarNamed: self slotName put: aDomainCreationContext
]
