Class {
	#name : #LcsOrganization,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'location'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsOrganization class >> parentSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LcsLegalEntitiesModule moduleName;
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
