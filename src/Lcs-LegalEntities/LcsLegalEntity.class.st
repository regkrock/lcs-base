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
	^ LcsStringSlot new
		slotName: 'entityName';
		yourself
]

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self slotVarNamed: 'entityName'
]

{ #category : #accessing }
LcsLegalEntity >> entityName: anObject [
	self slotVarNamed: 'entityName' put: anObject
]
