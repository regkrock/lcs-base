Class {
	#name : #LcsAddress,
	#superclass : #LcsDomainObject,
	#instVars : [
		'streetName',
		'postalCode',
		'streetNumber',
		'unit'
	],
	#category : #'Lcs-Geography-Domain'
}

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
		initialValueBlock: '[ '''' ]';
		yourself
]

{ #category : #'slot definitions' }
LcsAddress class >> streetNumberSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'streetNumber';
		addValidationCondition: [ :value :domainObject :oldValue | value isNilOrEmpty ] description: 'Street number is required';
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
