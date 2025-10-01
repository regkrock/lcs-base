"
This is where the configuration information for the module is stored.
"
Class {
	#name : #LcsGeographyModuleConfiguration,
	#superclass : #LcsBaseConfiguration,
	#instVars : [
		'defaultPostalCodeName',
		'defaultPoliticalUnitName'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPoliticalUnitNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPoliticalUnitName';
		beRequired;
		addValidationCondition: [ :string | string size < 3 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPostalCodeNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'defaultPostalCodeName';
		beRequired;
		addValidationCondition: [ :string | string size <= 2 ] description: 'Name must be at least 3 characters long';
		yourself
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
