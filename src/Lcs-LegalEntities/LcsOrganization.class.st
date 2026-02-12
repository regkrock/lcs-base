Class {
	#name : 'LcsOrganization',
	#superclass : 'LcsLegalEntity',
	#instVars : [
		'organizationName',
		'legalName'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsOrganization class >> legalNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'legalName';
		comment: 'This is the legal name,  enttity name is the "common" name for the organizsation';
		yourself
]

{ #category : 'slot definitions' }
LcsOrganization class >> mainAddressSlotDefinition [
	<collectionItemSlotDefinition>
	^ LcsInstanceInLocalCollectionSlot new
			slotName: 'mainAddress';
			addSlotType: LcsAddress;
			targetSlotPath: #(#addressType #code) asOrderedCollection;
			collectionSlotName: 'postalAddresses';
			targetItem: 'work';
			yourself
]

{ #category : 'slot definitions' }
LcsOrganization class >> organizationNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'organizationName';
		allowNil: false;
		yourself
]

{ #category : 'slot definitions' }
LcsOrganization class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		collectionSlotName: 'organizations';
		addSlotType: LcsOrganizations;
		yourself
]

{ #category : 'accessing' }
LcsOrganization >> fullName [
	^ self organizationName
]

{ #category : 'accessing' }
LcsOrganization >> legalName [
	^ self slotVarNamed: 'legalName'
]

{ #category : 'accessing' }
LcsOrganization >> legalName: anObject [
	self slotVarNamed: 'legalName' put: anObject
]

{ #category : 'accessing' }
LcsOrganization >> location [
	^ self slotVarNamed: 'location'
]

{ #category : 'accessing' }
LcsOrganization >> location: anObject [
	self slotVarNamed: 'location' put: anObject
]

{ #category : 'accessing' }
LcsOrganization >> mainAddress [
	^ self slotVarNamed: 'mainAddress'
]

{ #category : 'accessing' }
LcsOrganization >> mainAddress: anObject [
	self slotVarNamed: 'mainAddress' put: anObject
]

{ #category : 'accessing' }
LcsOrganization >> organizationName [
	^ self slotVarNamed: 'organizationName'
]

{ #category : 'accessing' }
LcsOrganization >> organizationName: anObject [
	self slotVarNamed: 'organizationName' put: anObject
]
