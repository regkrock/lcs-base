Class {
	#name : 'LxxPerson',
	#superclass : 'LxxBasePerson',
	#instVars : [
		'balance',
		'weight',
		'mainSkill',
		'skills',
		'hasRedHair'
	],
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LxxPerson class >> ageSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
		slotName: 'age';
		addSlotType: Integer;
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> balanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsScaledDecimalSlot new
		slotName: 'balance';
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> hasRedHairSlotDefinition [
	<accessorSlotDefinition>
	^ LcsBooleanSlot new
		slotName: 'hasRedHair';
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> mainSkillSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'mainSkill';
		addSlotType: LxxSkill;
		collectionSlotModuleName: 'Prototype System';
		collectionSlotName: 'skills';
		optionValueBlock: [ :object :slot | object skillCode ];
		displayStringBlock:[ :object :slot | object skillName ];
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> skillsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMembersOfGlobalCollectionSlot new
		slotName: 'skills';
		addSlotType: LxxSkills;
		addCollectionElementsSlotType: LxxSkill;
		collectionSlotModuleName: 'Prototype System';
		collectionSlotName: 'skills';
		optionValueBlock: [ :object :slot | object skillCode ];
		displayStringBlock:[ :object :slot | object skillName ];
		yourself
]

{ #category : 'slot definitions' }
LxxPerson class >> weightSlotDefinition [
	<accessorSlotDefinition>
	^ LcsNumberSlot new
		slotName: 'weight';
		yourself
]

{ #category : 'accessing' }
LxxPerson >> age [
	^ self slotVarNamed: 'age'
]

{ #category : 'accessing' }
LxxPerson >> balance [
	^ self slotVarNamed: 'balance'
]

{ #category : 'accessing' }
LxxPerson >> balance: anObject [
	self slotVarNamed: 'balance' put: anObject
]

{ #category : 'accessing' }
LxxPerson >> hasRedHair [
	^ self slotVarNamed: 'hasRedHair'
]

{ #category : 'accessing' }
LxxPerson >> hasRedHair: anObject [
	self slotVarNamed: 'hasRedHair' put: anObject
]

{ #category : 'accessing' }
LxxPerson >> mainSkill [
	^ self slotVarNamed: 'mainSkill'
]

{ #category : 'accessing' }
LxxPerson >> mainSkill: anObject [
	self slotVarNamed: 'mainSkill' put: anObject
]

{ #category : 'accessing' }
LxxPerson >> skills [
	^ self slotVarNamed: 'skills'
]

{ #category : 'accessing' }
LxxPerson >> skills: anObject [
	self slotVarNamed: 'skills' put: anObject
]

{ #category : 'accessing' }
LxxPerson >> weight [
	^ self slotVarNamed: 'weight'
]

{ #category : 'accessing' }
LxxPerson >> weight: anObject [
	self slotVarNamed: 'weight' put: anObject
]
