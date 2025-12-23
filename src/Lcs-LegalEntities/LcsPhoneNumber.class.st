Class {
	#name : 'LcsPhoneNumber',
	#superclass : 'LcsDomainObject',
	#traits : 'LtDateRange',
	#classTraits : 'LtDateRange classTrait',
	#instVars : [
		'phoneNumberType',
		'number'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsPhoneNumber class >> numberSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'number';
		yourself
]

{ #category : 'slot definitions' }
LcsPhoneNumber class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumbers);
		slotName: 'parent';
		collectionSlotName: 'phoneNumbers';
		collectionSlotModuleName: 'Legal Entities Module';
		yourself
]

{ #category : 'slot definitions' }
LcsPhoneNumber class >> phoneNumberTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumberType);
		slotName: 'phoneNumberType';
		collectionSlotName: 'phoneNumberTypes';
		collectionSlotModuleName: 'Legal Entities Module';
		yourself
]

{ #category : 'accessing' }
LcsPhoneNumber >> number [
	^ self slotVarNamed: 'number'
]

{ #category : 'accessing' }
LcsPhoneNumber >> number: anObject [
	self slotVarNamed: 'number' put: anObject
]

{ #category : 'accessing' }
LcsPhoneNumber >> phoneNumberType [
	^ self slotVarNamed: 'phoneNumberType'
]

{ #category : 'accessing' }
LcsPhoneNumber >> phoneNumberType: anObject [
	self slotVarNamed: 'phoneNumberType' put: anObject
]
