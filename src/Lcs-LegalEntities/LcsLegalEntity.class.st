Class {
	#name : 'LcsLegalEntity',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'mainAddress',
		'phoneNumber',
		'emailAddresses'
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
LcsLegalEntity class >> mainAddressSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
			addSlotType: LcsAddress;
			slotName: 'mainAddress';
			collectionSlotName: 'addresses';
			collectionSlotModuleName: 'Geography Module';
			yourself
]

{ #category : 'slot definitions' }
LcsLegalEntity class >> phoneNumberSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
			"initialValueBlock: [ :domainParent :slot | slot defaultInstance ];"
			addSlotType: LcsPhoneNumber;
			slotName: 'phoneNumber';
			collectionSlotName: 'phoneNumbers';
			collectionSlotModuleName: 'Legal Entities Module';
			yourself
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

{ #category : 'accessing' }
LcsLegalEntity >> mainAddress [
	^ self slotVarNamed: 'mainAddress'
]

{ #category : 'accessing' }
LcsLegalEntity >> mainAddress: anObject [
	self slotVarNamed: 'mainAddress' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumber [
	^ self slotVarNamed: 'phoneNumber'
]

{ #category : 'accessing' }
LcsLegalEntity >> phoneNumber: anObject [
	self slotVarNamed: 'phoneNumber' put: anObject
]
