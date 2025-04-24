Class {
	#name : #LcsPoliticalUnitName,
	#superclass : #LcsDomainObject,
	#instVars : [
		'fullName',
		'code'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsPoliticalUnitName class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'code';
		beRequired;
		addValidationCondition: [ :string | string size > 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #'slot definitions' }
LcsPoliticalUnitName class >> fullNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: #'fullName';
		beRequired;
		addValidationCondition: [ :string | string size > 2 ] description: 'Name must be at least 3 characters long';
		yourself
]

{ #category : #accessing }
LcsPoliticalUnitName >> code [ 
	^ self slotVarNamed: 'code'
]

{ #category : #accessing }
LcsPoliticalUnitName >> code: anObject [
	self slotVarNamed: 'code' put: anObject
]

{ #category : #accessing }
LcsPoliticalUnitName >> fullName [
	^ self slotVarNamed: 'fullName'
]

{ #category : #accessing }
LcsPoliticalUnitName >> fullName: anObject [
	self slotVarNamed: 'fullName' put: anObject
]
