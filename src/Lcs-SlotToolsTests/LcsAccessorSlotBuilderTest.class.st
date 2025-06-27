Class {
	#name : #LcsAccessorSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsAccessorSlotBuilderTest >> testInstallingSlot [
	self subject: (
		LcsAccessorSlotBuilder new
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
