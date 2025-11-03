Class {
	#name : #LxxPersons,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition' }
LxxPersons class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsUnknownSlot new
		addSlotType: LxxUnknownPerson;
		yourself
]

{ #category : #queries }
LxxPersons >> defaultInstance [
	^ self unknown
]

{ #category : #accessing }
LxxPersons >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LxxPersons >> unknown: anObject [
	^ self slotVarNamed: 'unknown' put: anObject
]
