Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'mainAddress'
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
	^ LcsMemberOfSlot new
		slotTypes: (OrderedCollection with: LcsAddress);
		slotName: 'mainAddress';
		collectionSlotName: 'addresses';
		collectionSlotModuleName: 'Geography Module';
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
