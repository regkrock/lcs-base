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

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPoliticalUnitNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'defaultPoliticalUnitName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> defaultPostalCodeNameSlotDefintion [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'defaultPostalCodeName';
		beRequired;
		validator: [ :string | string size >= 2 ];
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModuleConfiguration class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'parent';
		addSlotType: LcsGeographyModule;
		yourself
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName [
	^ self getValueOfSlotNamed: 'defaultPoliticalUnitName'
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPoliticalUnitName: anObject [
	^ self setValueOfSlotNamed: 'defaultPoliticalUnitName' to: anObject
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPostalCodeName [
	^ self getValueOfSlotNamed: 'defaultPostalCodeName'
]

{ #category : #accessing }
LcsGeographyModuleConfiguration >> defaultPostalCodeName: anObject [
	^ self setValueOfSlotNamed: 'defaultPostalCodeName' to: anObject
]
