Class {
	#name : #LcsCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'formalName',
		'subdivisionName',
		'isoCode3',
		'commonName',
		'subdivisions',
		'isoNumber'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsCountry class >> commonNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #commonName;
		beRequired;
		addValidationCondition: [ :string | string size < 3 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> formalNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #formalName;
		beRequired;
		addValidationCondition: [ :string | string size < 3 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCode3SlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode3';
		beRequired;
		addValidationCondition: [ :string | string size ~= 3 ] description: 'Code must be 3 characters long';		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode';
		beRequired;
		addValidationCondition: [ :string | string size ~= 2 ] description: 'Code must be 2 characters long';		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoNumberSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoNumber';
		"beRequired;
		addValidationCondition: [ :string | string size = 3 ] description: 'Code must be 3 characters long';"
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		collectionSlotName: 'countries';
		addSlotType: LcsCountries;
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> subdivisionNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #subdivisionName;
		beRequired;
		addValidationCondition: [ :string | string size < 3 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> subdivisionsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'subdivisions';
		addSlotType: LcsCountrySubdivisions;
		addCollectionMemberType: LcsBaseCountrySubdivision ;
		yourself
]

{ #category : #accessing }
LcsCountry >> commonName [
	^ self slotVarNamed: 'commonName'
]

{ #category : #accessing }
LcsCountry >> commonName: anObject [
	self slotVarNamed: 'commonName' put: anObject
]

{ #category : #accessing }
LcsCountry >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : #accessing }
LcsCountry >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : #accessing }
LcsCountry >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : #accessing }
LcsCountry >> isoCode3 [
	^ self slotVarNamed: 'isoCode3'
]

{ #category : #accessing }
LcsCountry >> isoCode3: anObject [
	self slotVarNamed: 'isoCode3' put: anObject
]

{ #category : #accessing }
LcsCountry >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : #accessing }
LcsCountry >> isoNumber [
	^ self slotVarNamed: 'isoNumber'
]

{ #category : #accessing }
LcsCountry >> isoNumber: anObject [
	self slotVarNamed: 'isoNumber' put: anObject
]

{ #category : #accessing }
LcsCountry >> subdivisionName [
	^ self slotVarNamed: 'subdivisionName'
]

{ #category : #accessing }
LcsCountry >> subdivisionName: anObject [
	self slotVarNamed: 'subdivisionName' put: anObject
]

{ #category : #accessing }
LcsCountry >> subdivisions [
	^ self slotVarNamed: 'subdivisions'
]

{ #category : #accessing }
LcsCountry >> subdivisions: anObject [
	self slotVarNamed: 'subdivisions' put: anObject
]
