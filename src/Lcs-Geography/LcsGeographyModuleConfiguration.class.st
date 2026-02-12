"
This is where the configuration information for the module is stored.
"
Class {
	#name : 'LcsGeographyModuleConfiguration',
	#superclass : 'LcsBaseConfiguration',
	#instVars : [
		'defaultPostalCodeName',
		'defaultPoliticalUnitName',
		'defaultCountry',
		'unknownPostalAddress'
	],
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultCountrySlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'defaultCountry';
		slotTypes: (OrderedCollection with: LcsCountry with: LcsUnknownCountry);
		collectionSlotModuleName: LcsGeographyModule defaultModuleName;
		collectionSlotName: 'countries';
		yourself
]

{ #category : 'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPoliticalUnitNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPoliticalUnitName';
		beRequired;
		addValidationCondition: [ :string :parentDomainObject :oldValue | string size < 3 ]
			description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPostalCodeNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPostalCodeName';
		beRequired;
		addValidationCondition: [ :string :parentDomainObject :oldValue | string size <= 2 ]
			description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : 'slot definitions' }
LcsGeographyModuleConfiguration class >> unknownPostalAddressSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			slotName: 'unknownPostalAddress';
			addSlotType: LcsUnknownAddress;
			required: true;
			yourself
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultCountry [
	^ self slotVarNamed: 'defaultCountry'
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultCountry: anObject [
	self slotVarNamed: 'defaultCountry' put: anObject
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName [
	^ self slotVarNamed: 'defaultPoliticalUnitName'
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName: anObject [
	^ self slotVarNamed: 'defaultPoliticalUnitName' put: anObject
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultPostalCodeName [
	^ self slotVarNamed: 'defaultPostalCodeName'
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> defaultPostalCodeName: anObject [
	^ self slotVarNamed: 'defaultPostalCodeName' put: anObject
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> unknownPostalAddress [
	^ self slotVarNamed: 'unknownPostalAddress'
]

{ #category : 'accessing' }
LcsGeographyModuleConfiguration >> unknownPostalAddress: anObject [
	self slotVarNamed: 'unknownPostalAddress' put: anObject
]
