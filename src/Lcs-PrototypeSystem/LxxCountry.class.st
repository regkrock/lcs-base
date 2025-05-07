Class {
	#name : #LxxCountry,
	#superclass : #LcsDomainObject,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definition' }
LxxCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'countries';
		collectionSlotModuleName: 'Prototype System';
		addSlotType: LxxCountries;
		yourself
]
