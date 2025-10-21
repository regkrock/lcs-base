Class {
	#name : #LcsAddress,
	#superclass : #LcsDomainObject,
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
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsAddress class >> additionalDeliveryInformationSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'additionalDeliveryInformation';
		allowNil: false;
		priority: 8;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> addressTypeSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsAddressType);
		slotName: 'addressType';
		collectionSlotName: 'addressTypes';
		collectionSlotModuleName: 'Geography Module';
		priority: 1;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> citySlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'city';
		required: true;
		priority: 12;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> countrySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'country';
		slotTypes: (OrderedCollection with: LcsCountry);
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findItemMatchingString: value ];
		collectionSlotName: 'countries';
		collectionSlotModuleName: 'Geography Module';
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

{ #category : #'slot definitions' }
LcsAddress class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsAddresses);
		slotName: 'parent';
		collectionSlotName: 'addresses';
		collectionSlotModuleName: 'Geography Module';
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> postBoxSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'postBox';
		allowNil: false;
		priority: 10;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> postalCodeSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotName: 'postalCode';
		addSubclassesOf: LcsBasePostCode;
		initialValueBlock: [ :domainObject :slot | domainObject country postalCodeClass new ];
		priority: 18;
		required: true;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> provinceSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfCollectionInSiblingSlotObjectSlot new
		slotName: 'province';
		siblingSlotName: 'country';
		siblingCollectionSlotName: 'subdivisions';
		required: true;
		addSubclassesOf: LcsBaseCountrySubdivision;
		priority: 17;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> streetNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'streetName';
		slotTypes: (OrderedCollection with: String);
		priority: 6;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> streetNumberSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'streetNumber';
		"addValidationCondition: [ :value :domainObject :oldValue | value isNilOrEmpty ] description: 'Street number is required';"
		allowNil: false;
		required: true;
		priority: 5;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> unitSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'unit';
		priority: 11;
		yourself
]

{ #category : #accessing }
LcsAddress >> additionalDeliveryInformation [
	^ self slotVarNamed: 'additionalDeliveryInformation'
]

{ #category : #accessing }
LcsAddress >> additionalDeliveryInformation: anObject [
	self slotVarNamed: 'additionalDeliveryInformation' put: anObject
]

{ #category : #accessing }
LcsAddress >> addressType [
	^ self slotVarNamed: 'addressType'
]

{ #category : #accessing }
LcsAddress >> addressType: anObject [
	self slotVarNamed: 'addressType' put: anObject
]

{ #category : #accessing }
LcsAddress >> city [
	^ self slotVarNamed: 'city'
]

{ #category : #accessing }
LcsAddress >> city: anObject [
	self slotVarNamed: 'city' put: anObject
]

{ #category : #accessing }
LcsAddress >> country [
	^ self slotVarNamed: 'country'
]

{ #category : #accessing }
LcsAddress >> country: anObject [
	self slotVarNamed: 'country' put: anObject
]

{ #category : #accessing }
LcsAddress >> postBox [
	^ self slotVarNamed: 'postBox'
]

{ #category : #accessing }
LcsAddress >> postBox: anObject [
	self slotVarNamed: 'postBox' put: anObject
]

{ #category : #accessing }
LcsAddress >> postalCode [
	^ self slotVarNamed: 'postalCode'
]

{ #category : #accessing }
LcsAddress >> postalCode: anObject [
	self slotVarNamed: 'postalCode' put: anObject
]

{ #category : #accessing }
LcsAddress >> province [
	^ self slotVarNamed: 'province'
]

{ #category : #accessing }
LcsAddress >> province: anObject [
	self slotVarNamed: 'province' put: anObject
]

{ #category : #accessing }
LcsAddress >> streetName [
	^ self slotVarNamed: 'streetName'
]

{ #category : #accessing }
LcsAddress >> streetName: anObject [
	self slotVarNamed: 'streetName' put: anObject
]

{ #category : #accessing }
LcsAddress >> streetNumber [
	^ self slotVarNamed: 'streetNumber'
]

{ #category : #accessing }
LcsAddress >> streetNumber: anObject [
	self slotVarNamed: 'streetNumber' put: anObject
]

{ #category : #accessing }
LcsAddress >> unit [
	^ self slotVarNamed: 'unit'
]

{ #category : #accessing }
LcsAddress >> unit: anObject [
	self slotVarNamed: 'unit' put: anObject
]
