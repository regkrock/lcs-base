Class {
	#name : 'LxxSkill',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'skillName',
		'skillCode'
	],
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definition' }
LxxSkill class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LxxSkills;
		collectionSlotName: 'skills';
		collectionSlotModuleName: 'Prototype System';
		yourself
]

{ #category : 'slot definitions' }
LxxSkill class >> skillCodeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'skillCode';
		required: true;
		yourself
]

{ #category : 'slot definitions' }
LxxSkill class >> skillNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'skillName';
		required: true;
		yourself
]

{ #category : 'accessing' }
LxxSkill >> skillCode [
	^ self slotVarNamed: 'skillCode'
]

{ #category : 'accessing' }
LxxSkill >> skillCode: anObject [
	self slotVarNamed: 'skillCode' put: anObject
]

{ #category : 'accessing' }
LxxSkill >> skillName [
	^ self slotVarNamed: 'skillName'
]

{ #category : 'accessing' }
LxxSkill >> skillName: anObject [
	self slotVarNamed: 'skillName' put: anObject
]
