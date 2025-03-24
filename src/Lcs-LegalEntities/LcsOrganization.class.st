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
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		collectionSlotName: 'organizations';
		yourself
]

{ #category : #accessing }
LcsOrganization >> location [
	^ self slotVarNamed: 'location'
]

{ #category : #accessing }
LcsOrganization >> location: anObject [
	self slotVarNamed: 'location' put: anObject
]
