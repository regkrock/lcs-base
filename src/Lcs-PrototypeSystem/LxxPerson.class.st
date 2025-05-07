Class {
	#name : #LxxPerson,
	#superclass : #LxxBasePerson,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself
]
