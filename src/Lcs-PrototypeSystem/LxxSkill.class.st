Class {
	#name : 'LxxSkill',
	#superclass : 'LcsDomainObject',
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
