Class {
	#name : #LcsGlobalCollectionSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsGlobalCollectionSlotBuilderTest >> testInstallingGlobalCollectionSlot [
	self subject: (
		LcsGlobalCollectionSlotBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			targetModuleClass: self currentSystem class name;
			collectionElementTypes: { LxxPerson name };
			addSlotType: LxxPersons name ;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation
]
