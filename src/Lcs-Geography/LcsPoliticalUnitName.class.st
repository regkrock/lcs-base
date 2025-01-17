Class {
	#name : #LcsPoliticalUnitName,
	#superclass : #LcsDomainObject,
	#instVars : [
		'fullName',
		'shortName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definition' }
LcsPoliticalUnitName class >> fullNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'fullName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #'slot definition' }
LcsPoliticalUnitName class >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'shortName';
		beRequired;
		validator: [ :string | string size > 2 ];
		yourself
]

{ #category : #accessing }
LcsPoliticalUnitName >> fullName [
	^ self getValueOfSlotNamed: 'fullName'
]

{ #category : #accessing }
LcsPoliticalUnitName >> fullName: anObject [
	self setValueOfSlotNamed: 'fullName' to: anObject
]

{ #category : #accessing }
LcsPoliticalUnitName >> shortName [
	^ self getValueOfSlotNamed: 'shortName'
]

{ #category : #accessing }
LcsPoliticalUnitName >> shortName: anObject [
	self setValueOfSlotNamed: 'shortName' to: anObject
]
