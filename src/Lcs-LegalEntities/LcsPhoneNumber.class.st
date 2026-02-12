Class {
	#name : 'LcsPhoneNumber',
	#superclass : 'LcsDomainObject',
	#traits : 'LtDateRange',
	#classTraits : 'LtDateRange classTrait',
	#instVars : [
		'phoneNumberType',
		'number'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
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
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
		yourself
]

{ #category : 'slot definitions' }
LcsPhoneNumber class >> phoneNumberTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumberType);
		slotName: 'phoneNumberType';
		collectionSlotName: 'phoneNumberTypes';
		collectionSlotModuleName: LcsLegalEntitiesModule defaultModuleName;
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
