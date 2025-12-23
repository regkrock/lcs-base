Class {
	#name : 'LcsEmailAddress',
	#superclass : 'LcsDomainObject',
	#traits : 'LtDateRange',
	#classTraits : 'LtDateRange classTrait',
	#instVars : [
		'email',
		'emailAddressType'
	],
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'slot definitions' }
LcsEmailAddress class >> emailAddressTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		addSlotType: LcsEmailAddressType;
		slotName: 'emailAddressType';
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findItemMatchingCode: value ifNone: [ value ] ];
		collectionSlotName: 'emailAddressTypes';
		collectionSlotModuleName: 'Legal Entities Module';
		yourself
]

{ #category : 'slot definitions' }
LcsEmailAddress class >> emailSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'email';
		addValidationCondition: [ :value "value isInvalidEmailFormat" :parentDomainObject :oldValue | false ]
			description: 'Invalid format';
		yourself
]

{ #category : 'slot definitions' }
LcsEmailAddress class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ super parentSlotDefinition	"^ LcsGlobalCollectionReferenceSlot new
			slotTypes: (OrderedCollection with: LcsEmailAddresses);
			slotName: 'parent';
			collectionSlotName: 'emailAddresses';
			collectionSlotModuleName: 'Legal Entities Module';
			yourself"
]

{ #category : 'accessing' }
LcsEmailAddress >> email [
	^ self slotVarNamed: 'email'
]

{ #category : 'accessing' }
LcsEmailAddress >> email: anObject [
	self slotVarNamed: 'email' put: anObject
]

{ #category : 'accessing' }
LcsEmailAddress >> emailAddressType [
	^ self slotVarNamed: 'emailAddressType'
]

{ #category : 'accessing' }
LcsEmailAddress >> emailAddressType: anObject [
	self slotVarNamed: 'emailAddressType' put: anObject
]
