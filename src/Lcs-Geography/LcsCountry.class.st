Class {
	#name : 'LcsCountry',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'isoCode',
		'formalName',
		'subdivisionName',
		'isoCode3',
		'commonName',
		'subdivisions',
		'isoNumber',
		'subdivisionClass',
		'postalCodeClass'
	],
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCountry class >> commonNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #commonName;
		beRequired;
		initialValue: '   ';
		allowEmptyIntialValue;
		addValidationCondition: [ :value :parentDomainObject :oldValue | value size < 3 ]
			description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> formalNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #formalName;
		beRequired;
		initialValue: '   ';
		allowEmptyIntialValue;
		addValidationCondition: [ :value :parentDomainObject :oldValue | value size < 3 ]
			description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> isoCode3SlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #isoCode3;
		beRequired;
		initialValue: '   ';
		allowEmptyIntialValue;
		addValidationCondition: [ :value :parentDomainObject :oldValue | value size ~= 3 ]
			description: 'Code must be 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> isoCodeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #isoCode;
		beRequired;
		initialValue: '  ';
		allowEmptyIntialValue;
		addValidationCondition: [ :value :parentDomainObject :oldValue | value size ~= 2 ]
			description: 'Code must be 2 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> isoNumberSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #isoNumber;
		initialValue: '   ';
		allowEmptyIntialValue;
		addValidationCondition: [ :value :parentDomainObject :oldValue | value size ~= 3 ]
			description: 'Code must be 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		collectionSlotName: 'countries';
		addSlotType: LcsCountries;
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> postalCodeClassSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPostalCodeClassSlot new
]

{ #category : 'slot definitions' }
LcsCountry class >> subdivisionClassSlotDefinition [
	<accessorSlotDefinition>
	^ LcsCountrySubdivisionClassSlot new
]

{ #category : 'slot definitions' }
LcsCountry class >> subdivisionNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: #subdivisionName;
		allowEmptyIntialValue;
		yourself
]

{ #category : 'slot definitions' }
LcsCountry class >> subdivisionsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'subdivisions';
		addSlotType: LcsCountrySubdivisions;
		addCollectionMemberType: LcsBaseCountrySubdivision;
		yourself
]

{ #category : 'accessing' }
LcsCountry >> commonName [
	^ self slotVarNamed: 'commonName'
]

{ #category : 'accessing' }
LcsCountry >> commonName: anObject [
	self slotVarNamed: 'commonName' put: anObject
]

{ #category : 'printing' }
LcsCountry >> displayString [
	^ self commonName asString
]

{ #category : 'accessing' }
LcsCountry >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : 'accessing' }
LcsCountry >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : 'accessing' }
LcsCountry >> isoCode3 [
	^ self slotVarNamed: 'isoCode3'
]

{ #category : 'accessing' }
LcsCountry >> isoCode3: anObject [
	self slotVarNamed: 'isoCode3' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> isoNumber [
	^ self slotVarNamed: 'isoNumber'
]

{ #category : 'accessing' }
LcsCountry >> isoNumber: anObject [
	self slotVarNamed: 'isoNumber' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> postalCodeClass [
	^ self slotVarNamed: 'postalCodeClass'
]

{ #category : 'accessing' }
LcsCountry >> postalCodeClass: anObject [
	self slotVarNamed: 'postalCodeClass' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> subdivisionClass [
	^ self slotVarNamed: 'subdivisionClass'
]

{ #category : 'accessing' }
LcsCountry >> subdivisionClass: anObject [
	self slotVarNamed: 'subdivisionClass' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> subdivisionName [
	^ self slotVarNamed: 'subdivisionName'
]

{ #category : 'accessing' }
LcsCountry >> subdivisionName: anObject [
	self slotVarNamed: 'subdivisionName' put: anObject
]

{ #category : 'accessing' }
LcsCountry >> subdivisions [
	^ self slotVarNamed: 'subdivisions'
]

{ #category : 'accessing' }
LcsCountry >> subdivisions: anObject [
	self slotVarNamed: 'subdivisions' put: anObject
]
