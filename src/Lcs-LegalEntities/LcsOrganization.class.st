Class {
	#name : #LcsOrganization,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'organizationName',
		'committees'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsOrganization class >> committeesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsCommittees);
		collectionMemberTypes: (OrderedCollection with: LcsCommittee);
		slotName: 'committees';
		yourself
]

{ #category : #'slot definitions' }
LcsOrganization class >> organizationNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'organizationName';
		allowNil: false;
		yourself
]

{ #category : #'slot definitions' }
LcsOrganization class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
			collectionSlotName: 'organizations';
			addSlotType: LcsOrganizations;
			yourself
]

{ #category : #accessing }
LcsOrganization >> committees [
	^ self slotVarNamed: 'committees'
]

{ #category : #accessing }
LcsOrganization >> committees: anObject [
	self slotVarNamed: 'committees' put: anObject
]

{ #category : #accessing }
LcsOrganization >> fullName [
	^ self organizationName
]

{ #category : #accessing }
LcsOrganization >> location [
	^ self slotVarNamed: 'location'
]

{ #category : #accessing }
LcsOrganization >> location: anObject [
	self slotVarNamed: 'location' put: anObject
]

{ #category : #accessing }
LcsOrganization >> organizationName [
	^ self slotVarNamed: 'organizationName'
]

{ #category : #accessing }
LcsOrganization >> organizationName: anObject [
	self slotVarNamed: 'organizationName' put: anObject
]
