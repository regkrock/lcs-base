Class {
	#name : #LcsPersons,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPersons class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsUnknownSlot new
			addSlotType: LcsUnknownPerson;
			yourself
]

{ #category : #queries }
LcsPersons >> defaultInstance [
	^ self unknown
]

{ #category : #accessing }
LcsPersons >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LcsPersons >> unknown: anObject [
	self slotVarNamed: 'unknown' put: anObject
]
