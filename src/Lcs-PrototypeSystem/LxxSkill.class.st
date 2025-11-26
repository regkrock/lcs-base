Class {
	#name : 'LxxSkill',
	#superclass : 'LcsDomainObject',
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition' }
LxxSkill class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			addSlotType: LxxSkills;
			collectionSlotName: 'skills';
			collectionSlotModuleName: 'Prototype System';
			yourself
]
