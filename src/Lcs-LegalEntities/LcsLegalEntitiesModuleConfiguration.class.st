Class {
	#name : 'LcsLegalEntitiesModuleConfiguration',
	#superclass : 'LcsBaseConfiguration',
	#instVars : [
		'unknownPerson'
	],
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsLegalEntitiesModuleConfiguration class >> unknownPersonSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
		slotName: 'unknownPerson';
		addSlotType: LcsUnknownPerson;
		yourself
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPerson [
	^ self slotVarNamed: 'unknownPerson'
]

{ #category : 'accessing' }
LcsLegalEntitiesModuleConfiguration >> unknownPerson: anObject [
	self slotVarNamed: 'unknownPerson' put: anObject
]
