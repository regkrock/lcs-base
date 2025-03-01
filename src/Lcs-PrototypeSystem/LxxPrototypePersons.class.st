Class {
	#name : #LxxPrototypePersons,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition' }
LxxPrototypePersons class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'unknown';
		addSlotType: LxxPrototypeUnknownPerson;
		yourself
]

{ #category : #queries }
LxxPrototypePersons >> defaultInstance [
	^ self unknown
]

{ #category : #accessing }
LxxPrototypePersons >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : #accessing }
LxxPrototypePersons >> unknown: anObject [
	^ self slotVarNamed: 'unknown' put: anObject
]
