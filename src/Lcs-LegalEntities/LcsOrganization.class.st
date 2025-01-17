Class {
	#name : #LcsOrganization,
	#superclass : #LcsLegalEntity,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsOrganization class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsLegalEntitiesModule moduleName;
		collectionSlotName: 'organizations';
		yourself
]

{ #category : #accessing }
LcsOrganization >> location [
	^ self getValueOfSlotNamed: 'location'
]

{ #category : #accessing }
LcsOrganization >> location: anObject [
	self setValueOfSlotNamed: 'location' to: anObject
]
