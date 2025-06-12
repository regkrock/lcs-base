Class {
	#name : #LcsSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSlotDefinitionBuilderTest >> testInstallingSlot [
	self subject: (
		LcsSlotDefinitionBuilder new
			slotName: 'foos';
			slotDefinitionClassName: LcsStringSlot name;
			targetClassName: self currentSystem class name;
			addSlotType: LxxPerson name ;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel
]
