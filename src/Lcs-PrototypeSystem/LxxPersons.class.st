Class {
	#name : 'LxxPersons',
	#superclass : 'LcsDomainCollection',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition' }
LxxPersons class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		addSlotType: LxxUnknownPerson;
		yourself
]

{ #category : 'queries' }
LxxPersons >> defaultInstance [
	^ self unknownInstance
]

{ #category : 'accessing' }
LxxPersons >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LxxPersons >> unknownInstance: anObject [
	^ self slotVarNamed: 'unknown' put: anObject
]
