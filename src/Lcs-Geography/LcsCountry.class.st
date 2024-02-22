Class {
	#name : #LcsCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'countryName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsCountry >> countryName [
	^ self getValueOfSlotNamed: 'countryName'
]

{ #category : #accessing }
LcsCountry >> countryName: anObject [
	self setValueOfSlotNamed: 'countryName' to: anObject
]

{ #category : #accessing }
LcsCountry >> countryNameSlotDefintion [
	<slotDefinition>
	^LcsStringSlotDefinition new
		slotName: #'countryName';
		beRequired;
		validator: [:string | string size > 2];
		yourself
]

{ #category : #accessing }
LcsCountry >> isoCode [
	^ self getValueOfSlotNamed: 'isoCode'
]

{ #category : #accessing }
LcsCountry >> isoCode: anObject [
	self setValueOfSlotNamed: 'isoCode' to: anObject
]

{ #category : #accessing }
LcsCountry >> isoCodeSlotDefintion [
	<slotDefinition>
	^LcsStringSlotDefinition new
		slotName: #'isoCode';
		beRequired;
		validator: [:string | string size = 2];
		yourself
]
