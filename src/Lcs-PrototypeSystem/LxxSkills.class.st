Class {
	#name : 'LxxSkills',
	#superclass : 'LcsDomainCollection',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definition' }
LxxSkills class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		addSlotType: LxxUnknownSkill;
		yourself
]

{ #category : 'accessing' }
LxxSkills >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LxxSkills >> unknownInstance: anObject [
	self slotVarNamed: 'unknownInstance' put: anObject
]
