Class {
	#name : 'LcsLegalEntitiesModuleConfiguration',
	#superclass : 'LcsBaseConfiguration',
	#instVars : [
		'unknownEmailAddress',
		'unknownPhoneNumber',
		'unknownPerson'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsLegalEntitiesModuleConfiguration class >> unknownEmailAddressSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		slotName: 'unknownEmailAddress';
		addSlotType: LcsUnknownEmailAddress;
		yourself
]

{ #category : 'slot definitions' }
LcsLegalEntitiesModuleConfiguration class >> unknownPersonSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		slotName: 'unknownPerson';
		addSlotType: LcsUnknownPerson;
		yourself
]

{ #category : 'slot definitions' }
LcsLegalEntitiesModuleConfiguration class >> unknownPhoneNumberSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		slotName: 'unknownPhoneNumber';
		addSlotType: LcsUnknownPhoneNumber;
		yourself
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownEmailAddress [
	^ self slotVarNamed: 'unknownEmailAddress'
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownEmailAddress: anObject [
	self slotVarNamed: 'unknownEmailAddress' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPerson [
	^ self slotVarNamed: 'unknownPerson'
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPerson: anObject [
	self slotVarNamed: 'unknownPerson' put: anObject
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPhoneNumber [
	^ self slotVarNamed: 'unknownPhoneNumber'
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPhoneNumber: anObject [
	self slotVarNamed: 'unknownPhoneNumber' put: anObject
]
