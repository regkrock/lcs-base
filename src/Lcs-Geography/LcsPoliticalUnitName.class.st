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
	^ self slotVarNamed: 'fullName'
]

{ #category : #accessing }
LcsPoliticalUnitName >> fullName: anObject [
	self slotVarNamed: 'fullName' put: anObject
]

{ #category : #accessing }
LcsPoliticalUnitName >> shortName [
	^ self slotVarNamed: 'shortName'
]

{ #category : #accessing }
LcsPoliticalUnitName >> shortName: anObject [
	self slotVarNamed: 'shortName' put: anObject
]
