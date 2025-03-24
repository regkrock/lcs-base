Class {
	#name : #LxxPrototypePerson,
	#superclass : #LxxBasePrototypePerson,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPrototypePerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPrototypePersons;
		collectionSlotName: 'persons';
		yourself
]
