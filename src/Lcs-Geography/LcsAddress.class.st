Class {
	#name : 'LcsAddress',
	#superclass : 'LcsDomainObject',
	#traits : 'LtDateRange',
	#classTraits : 'LtDateRange classTrait',
	#instVars : [
		'streetName',
		'postalCode',
		'streetNumber',
		'unit',
		'addressType',
		'postBox',
		'additionalDeliveryInformation',
		'city',
		'country',
		'province'
	],
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsAddress class >> additionalDeliveryInformationSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'additionalDeliveryInformation';
		allowNil: false;
		priority: 8;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> addressTypeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'addressType';
		addSlotType: LcsAddressType;
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findItemMatchingCode: value ifNone: [ value ] ];
		collectionSlotName: 'addressTypes';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		priority: 1;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> citySlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'city';
		required: true;
		priority: 12;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> countrySlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'country';
		slotTypes: (OrderedCollection with: LcsCountry);
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findItemMatchingCodeOrName: value ifNone: [ value ] ];
		collectionSlotName: 'countries';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		priority: 16;
		addPostUpdateAction: (LcsUpdateSiblingWithCollectionDefault new
				description: 'When country changes, update the default province';
				siblingSlotName: 'province';
				sourceCollectionSlotName: 'subdivisions';
				yourself);
		addPostUpdateAction: (LcsUpdateSiblingWithNewInstanceOfSourceClass new
				description: 'When country changes, update the new postal code';
				siblingSlotName: 'postalCode';
				sourceSlotName: 'postalCodeClass';
				yourself);
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsAddresses);
		slotName: 'parent';
		collectionSlotName: 'addresses';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> postBoxSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'postBox';
		allowNil: false;
		priority: 10;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> postCodeSlotDefinition [
	<facadeSlotDefinition>
	^ LcsDelegatorSlot new
			slotName: 'postCode';
			targetSlotPath: #('postalCode'  'code');
			yourself

]

{ #category : 'slot definitions' }
LcsAddress class >> postalCodeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPostalCodeSlot new
]

{ #category : 'slot definitions' }
LcsAddress class >> provinceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfCollectionInSiblingSlotObjectSlot new
		slotName: 'province';
		prevalidationTransformBlock: [ :value :slot :parentDomainObject | 
			(slot targetCollectionIn: parentDomainObject)
				findItemMatchingCode: value
				ifNone: [ value ] ];
		siblingSlotName: 'country';
		siblingCollectionSlotName: 'subdivisions';
		required: true;
		addSubclassesOf: LcsBaseCountrySubdivision;
		priority: 17;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> streetNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'streetName';
		slotTypes: (OrderedCollection with: String);
		priority: 6;
		yourself
]

{ #category : 'slot definitions' }
LcsAddress class >> streetNumberSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'streetNumber';
		allowNil: false;
		required: true;
		priority: 5;
		yourself	"addValidationCondition: [ :value :parentDomainObject :oldValue | value isNilOrEmpty ] description: 'Street number is required';"
]

{ #category : 'slot definitions' }
LcsAddress class >> unitSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'unit';
		priority: 11;
		yourself
]

{ #category : 'accessing' }
LcsAddress >> additionalDeliveryInformation [
	^ self slotVarNamed: 'additionalDeliveryInformation'
]

{ #category : 'accessing' }
LcsAddress >> additionalDeliveryInformation: anObject [
	self slotVarNamed: 'additionalDeliveryInformation' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> addressType [
	^ self slotVarNamed: 'addressType'
]

{ #category : 'accessing' }
LcsAddress >> addressType: anObject [
	self slotVarNamed: 'addressType' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> city [
	^ self slotVarNamed: 'city'
]

{ #category : 'accessing' }
LcsAddress >> city: anObject [
	self slotVarNamed: 'city' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> country [
	^ self slotVarNamed: 'country'
]

{ #category : 'accessing' }
LcsAddress >> country: anObject [
	self slotVarNamed: 'country' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> postBox [
	^ self slotVarNamed: 'postBox'
]

{ #category : 'accessing' }
LcsAddress >> postBox: anObject [
	self slotVarNamed: 'postBox' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> postCode [
	^ self slotVarNamed: 'postCode'
]

{ #category : 'accessing' }
LcsAddress >> postCode: anObject [
	self slotVarNamed: 'postCode' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> postalCode [
	^ self slotVarNamed: 'postalCode'
]

{ #category : 'accessing' }
LcsAddress >> postalCode: anObject [
	self slotVarNamed: 'postalCode' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> province [
	^ self slotVarNamed: 'province'
]

{ #category : 'accessing' }
LcsAddress >> province: anObject [
	self slotVarNamed: 'province' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> streetName [
	^ self slotVarNamed: 'streetName'
]

{ #category : 'accessing' }
LcsAddress >> streetName: anObject [
	self slotVarNamed: 'streetName' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> streetNumber [
	^ self slotVarNamed: 'streetNumber'
]

{ #category : 'accessing' }
LcsAddress >> streetNumber: anObject [
	self slotVarNamed: 'streetNumber' put: anObject
]

{ #category : 'accessing' }
LcsAddress >> unit [
	^ self slotVarNamed: 'unit'
]

{ #category : 'accessing' }
LcsAddress >> unit: anObject [
	self slotVarNamed: 'unit' put: anObject
]
