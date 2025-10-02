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
		'additionalDeliveryInformation'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsAddress class >> additionalDeliveryInformationSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'additionalDeliveryInformation';
		allowNil: false;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> addressTypeSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotTypes: (OrderedCollection with: LcsAddressType);
		slotName: 'addressType';
		collectionSlotName: 'addressTypes';
		collectionSlotModuleName: 'Geography Module';
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> postBoxSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'postBox';
		allowNil: false;
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> postalCodeSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotName: 'postalCode';
		required: true;
		slotTypes: (OrderedCollection with: LcsPostalCode);
		initialValueBlock: [ :parentDomainObject :slot | 
			(slot slotTypes any new)
				parent: parentDomainObject;
				yourself ];
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> streetNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'streetName';
		slotTypes: (OrderedCollection with: String);
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
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> unitSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'unit';
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
