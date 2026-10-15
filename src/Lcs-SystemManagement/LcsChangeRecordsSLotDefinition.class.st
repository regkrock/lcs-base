Class {
	#name : 'LcsChangeRecordsSLotDefinition',
	#superclass : 'LcsLocalCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsChangeRecordsSLotDefinition >> initialize [
	super initialize.
	self
		slotName: 'changeRecords';
		addSlotType: LcsDomainObjectChangeRecords;
		addCollectionMemberType: LcsDomainObjectChangeRecord;
		beRequired;
		makeDirectUpdateOfVariable	
		"beReadOnly;"
]
