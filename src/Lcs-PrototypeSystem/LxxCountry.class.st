Class {
	#name : #LxxCountry,
	#superclass : #LcsDomainObject,
	#instVars : [
		'isoCode',
		'formalName',
		'isoCode3',
		'isoNumber',
		'commonName'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definition' }
LxxCountry class >> commonNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'commonName';
		addValidationCondition: [ :value | value size <= 2 ] description: 'Must be 3 or more characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> formalNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'formalName';
		addValidationCondition: [ :value | value size <= 2 ] description: 'Must be 3 or more characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoCode3SlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoCode3';
		addValidationCondition: [ :value | (value size = 3) not ] description: 'Must be 3 characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoCodeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoCode';
		addValidationCondition: [ :value | (value size = 2) not ] description: 'Must be 2 characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> isoNumberSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'isoNumber';
		addValidationCondition: [ :value | (value size = 3) not ] description: 'Must be 3 characters. Example: "001"';
		addValidationCondition: [ :value | value asInteger > 0 and: [ value asInteger < 1000 ] ] description: 'Must be 3 characters';
		yourself
]

{ #category : #'slot definition' }
LxxCountry class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotName: 'countries';
		collectionSlotModuleName: 'Prototype System';
		addSlotType: LxxCountries;
		yourself
]

{ #category : #accessing }
LxxCountry >> commonName [
	^ self slotVarNamed: 'commonName'
]

{ #category : #accessing }
LxxCountry >> commonName: anObject [
	self slotVarNamed: 'commonName' put: anObject
]

{ #category : #accessing }
LxxCountry >> formalName [
	^ self slotVarNamed: 'formalName'
]

{ #category : #accessing }
LxxCountry >> formalName: anObject [
	self slotVarNamed: 'formalName' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoCode [
	^ self slotVarNamed: 'isoCode'
]

{ #category : #accessing }
LxxCountry >> isoCode3 [
	^ self slotVarNamed: 'isoCode3'
]

{ #category : #accessing }
LxxCountry >> isoCode3: anObject [
	self slotVarNamed: 'isoCode3' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoCode: anObject [
	self slotVarNamed: 'isoCode' put: anObject
]

{ #category : #accessing }
LxxCountry >> isoNumber [
	^ self slotVarNamed: 'isoNumber'
]

{ #category : #accessing }
LxxCountry >> isoNumber: anObject [
	self slotVarNamed: 'isoNumber' put: anObject
]
