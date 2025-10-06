"
This is where the configuration information for the module is stored.
"
Class {
	#name : #LcsGeographyModuleConfiguration,
	#superclass : #LcsBaseConfiguration,
	#instVars : [
		'defaultPostalCodeName',
		'defaultPoliticalUnitName',
		'defaultCountry'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultCountrySlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'defaultCountry';
		slotTypes: (OrderedCollection with: LcsCountry);
		collectionSlotModuleName: 'Geography Module';
		collectionSlotName: 'countries';
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPoliticalUnitNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPoliticalUnitName';
		beRequired;
		addValidationCondition: [ :string :domainObject :oldValue | string size < 3 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPostalCodeNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPostalCodeName';
		beRequired;
		addValidationCondition: [ :string :domainObject :oldValue | string size <= 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultCountry [
	^ self slotVarNamed: 'defaultCountry'
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultCountry: anObject [
	self slotVarNamed: 'defaultCountry' put: anObject
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName [
	^ self slotVarNamed: 'defaultPoliticalUnitName'
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName: anObject [
	^ self slotVarNamed: 'defaultPoliticalUnitName' put: anObject
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPostalCodeName [
	^ self slotVarNamed: 'defaultPostalCodeName'
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPostalCodeName: anObject [
	^ self slotVarNamed: 'defaultPostalCodeName' put: anObject
]
