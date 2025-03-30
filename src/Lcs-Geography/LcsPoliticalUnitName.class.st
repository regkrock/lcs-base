Class {
	#name : #LcsPoliticalUnitName,
	#superclass : #LcsDomainObject,
	#instVars : [
		'fullName',
		'shortName'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsPoliticalUnitName class >> fullNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'fullName';
		beRequired;
		addValidationCondition: [ :string | string size > 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsPoliticalUnitName class >> shortNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'shortName';
		beRequired;
		addValidationCondition: [ :string | string size > 2 ] description: 'Name must be at least 3 characters long';
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
