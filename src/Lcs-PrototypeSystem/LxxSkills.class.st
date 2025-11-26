Class {
	#name : 'LxxSkills',
	#superclass : 'LcsDomainCollection',
	#instVars : [
		'unknown'
	],
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition' }
LxxSkills class >> unknownSlotDefinition [
	<slotDefinition>
	^ LcsDomainObjectSlot new
		slotName: 'unknown';
		addSlotType: LxxUnknownSkill;
		yourself
]

{ #category : 'accessing' }
LxxSkills >> unknown [
	^ self slotVarNamed: 'unknown'
]

{ #category : 'accessing' }
LxxSkills >> unknown: anObject [
	self slotVarNamed: 'unknown' put: anObject
]
