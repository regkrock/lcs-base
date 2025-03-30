Class {
	#name : #LcsCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'countryName',
		'politicalUnitName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsCountry class >> countryNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'countryName';
		beRequired;
		addValidationCondition: [ :string | string size >= 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode';
		beRequired;
		addValidationCondition: [ :string | string size = 2 ] description: 'Code must be at least 2 characters long';		yourself
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
LcsCountry class >> politicalUnitNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'politicalUnitName';
		beRequired;
		addValidationCondition: [ :string | string size >= 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #accessing }
LcsCountry >> countryName [
	^ self slotVarNamed: 'countryName'
]

{ #category : #accessing }
LcsCountry >> countryName: anObject [
	self slotVarNamed: 'countryName' put: anObject
]

{ #category : #accessing }
LcsCountry >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : #accessing }
LcsCountry >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : #accessing }
LcsCountry >> politicalUnitName [
	^ self slotVarNamed: 'politicalUnitName'
]

{ #category : #accessing }
LcsCountry >> politicalUnitName: anObject [
	self slotVarNamed: 'politicalUnitName' put: anObject
]
