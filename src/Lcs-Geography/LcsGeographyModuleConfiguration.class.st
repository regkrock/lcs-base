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
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: #'defaultPoliticalUnitName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPostalCodeNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: #'defaultPostalCodeName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: 'parent';
		yourself
]
