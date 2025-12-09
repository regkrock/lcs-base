Class {
	#name : 'LcsLegalEntity',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'emailAddresses',
		'postalAddresses',
		'phoneNumbers'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsLegalEntity class >> emailAddressesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
			slotName: 'emailAddresses';
			addSlotType: LcsEmailAddresses;
			collectionClass: IdentitySet;
			dependentGlobalCollectionModuleName: 'Legal Entities Module';
			dependentGlobalCollectionSlotName: 'emailAddresses';
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> entityNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
			slotName: 'entityName';
			valueAccessor: #fullName;
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> phoneNumbersSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
			slotName: 'phoneNumbers';
			addSlotType: LcsPhoneNumbers;
			addCollectionMemberType: LcsPhoneNumber;
			collectionClass: IdentitySet;
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> postalAddressesSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
			slotName: 'postalAddresses';
			addSlotType: LcsAddresses;
			addCollectionMemberType: LcsAddress;
			collectionClass: IdentitySet;
			yourself
]

{ #category : 'as yet unclassified' }
LcsLegalEntity >> contactWithFirstName: aFirstName familyName: aFamilyName [
	^ self currentSystem legalEntitiesModule contactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'accessing' }
LcsLegalEntity >> emailAddresses [
	^ self slotVarNamed: 'emailAddresses'
]

{ #category : 'accessing' }
LcsLegalEntity >> emailAddresses: anObject [
	self slotVarNamed: 'emailAddresses' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntity >> entityName [
	^ self virtualSlotVarNamed: 'entityName'
]

{ #category : 'as yet unclassified' }
LcsLegalEntity >> hasContactWithFirstName: aFirstName familyName: aFamilyName [
	^ self currentSystem legalEntitiesModule hasContactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumbers [
	^ self slotVarNamed: 'phoneNumbers'
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumbers: anObject [
	self slotVarNamed: 'phoneNumbers' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntity >> postalAddresses [
	^ self slotVarNamed: 'postalAddresses'
]

{ #category : 'accessing' }
LcsLegalEntity >> postalAddresses: anObject [
	self slotVarNamed: 'postalAddresses' put: anObject
]
