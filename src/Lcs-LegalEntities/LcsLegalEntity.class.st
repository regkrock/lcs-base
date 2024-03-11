Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'entityName'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsLegalEntity class >> entityNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: 'entityName';
		yourself
]

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self getValueOfSlotNamed: 'entityName'
]

{ #category : #accessing }
LcsLegalEntity >> entityName: anObject [
	self setValueOfSlotNamed: 'entityName' to: anObject
]

{ #category : #accessing }
LcsLegalEntity >> entityNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: 'entityName';
		yourself
]
