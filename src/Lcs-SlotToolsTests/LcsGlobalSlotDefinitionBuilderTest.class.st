Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingGlobalCollectionSlot [
	self subject: (
		LcsGlobalSlotDefinitionBuilder new
			slotClassName: LxxPersons name;
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			targetModuleClass: self currentSystem class name;
			collectionElementTypes: { LxxPerson name };
			slotTypes: { LxxPersons name };
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation
]
