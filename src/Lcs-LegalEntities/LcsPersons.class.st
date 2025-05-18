Class {
	#name : #LcsPersons,
	#superclass : #LcsDomainCollection,
	#instVars : [
		'unknown'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definition' }
LcsPersons class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsCompositeSlot new
		slotName: 'unknown';
		addSlotType: UndefinedObject;
		addSlotType: LcsUnknownPerson;
		initialValueBlock: [ nil ];
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
