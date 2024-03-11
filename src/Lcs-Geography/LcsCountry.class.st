Class {
	#name : #LcsCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'countryName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsCountry class >> countryNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: #'countryName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> isoCodeSlotDefintion [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: #'isoCode';
		beRequired;
		validator: [ :string | string size = 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LcsGeographyModule moduleName;
		collectionSlotName: 'countries';
		yourself
]

{ #category : #accessing }
LcsCountry >> countryName [
	^ self getValueOfSlotNamed: 'countryName'
]

{ #category : #accessing }
LcsCountry >> countryName: anObject [
	self setValueOfSlotNamed: 'countryName' to: anObject
]

{ #category : #accessing }
LcsCountry >> isoCode [
	^ self getValueOfSlotNamed: 'isoCode'
]

{ #category : #accessing }
LcsCountry >> isoCode: anObject [
	self setValueOfSlotNamed: 'isoCode' to: anObject
]
