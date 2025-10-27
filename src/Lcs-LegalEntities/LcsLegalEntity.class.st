Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'mainAddress',
		'phoneNumber'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsLegalEntity class >> entityNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
		slotName: 'entityName';
		valueAccessor: #fullName;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntity class >> mainAddressSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsAddress);
		slotName: 'mainAddress';
		collectionSlotName: 'addresses';
		collectionSlotModuleName: 'Geography Module';
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntity class >> phoneNumberSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		initialValueBlock: [ :domainParent :slot | slot newInstance ];
		slotTypes: (OrderedCollection with: LcsPhoneNumber);
		slotName: 'phoneNumber';
		collectionSlotName: 'phoneNumbers';
		collectionSlotModuleName: 'Legal Entities Module';
		yourself
]

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self virtualSlotVarNamed: 'entityName'
]

{ #category : #accessing }
LcsLegalEntity >> mainAddress [
	^ self slotVarNamed: 'mainAddress'
]

{ #category : #accessing }
LcsLegalEntity >> mainAddress: anObject [
	self slotVarNamed: 'mainAddress' put: anObject
]

{ #category : #accessing }
LcsLegalEntity >> phoneNumber [
	^ self slotVarNamed: 'phoneNumber'
]

{ #category : #accessing }
LcsLegalEntity >> phoneNumber: anObject [
	self slotVarNamed: 'phoneNumber' put: anObject
]
