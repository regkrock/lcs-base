Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'entityName'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self getValueOfSlotNamed: 'entityName'
]

{ #category : #accessing }
LcsLegalEntity >> entityName: anObject [
	self setValueOfSlotNamed: 'entityName' to: anObject
]

{ #category : #accessing }
LcsLegalEntity >> entityNamelotDefinition [
	<slotDefinition>
	^ LcsStringSlotDefinition new
		slotName: 'entityName';
		yourself
]
