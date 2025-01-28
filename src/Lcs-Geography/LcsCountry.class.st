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
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'isoCode';
		beRequired;
		validator: [ :string | string size = 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsGeographyModule moduleName;
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
		validator: [ :string | string size = 2 ];
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
