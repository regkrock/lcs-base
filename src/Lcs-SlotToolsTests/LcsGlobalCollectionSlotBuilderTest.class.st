Class {
	#name : 'LcsGlobalCollectionSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsGlobalCollectionSlotBuilderTest >> testInstallingGlobalCollectionSlot [
	self subject: (
		LcsGlobalCollectionSlotBuilder new
			slotName: 'foos';
			targetClassName: LxxPrototypeSystem name;
			targetModuleClass: LxxPrototypeSystem name;
			collectionMemberTypes: (OrderedCollection with:  LxxPerson name );
			addSlotType: LxxPersons name ;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation
]

{ #category : 'tests' }
LcsGlobalCollectionSlotBuilderTest >> testSlotDefinitionSourceCode [
	self subject: (
		LcsGlobalCollectionSlotBuilder new
			slotName: 'foos';
			targetClassName: LxxPrototypeSystem name;
			targetModuleClass: LxxPrototypeSystem name;
			collectionMemberTypes: (OrderedCollection with:  LxxPerson name );
			addSlotType: LxxPersons name ;
			yourself).
	self subject buildJobSteps.
		self assert: (self subject jobStep: 2) slotDefinitionSource equals: 
'foosSlotDefinition
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
			addSlotType: LxxPersons;
			addCollectionMemberType: LxxPerson;
			slotName: ''foos'';
			yourself'
]
