Class {
	#name : #LcsAccessorSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsAccessorSlotBuilderTest >> testCreation [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject validationConditions hasNoElements.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotClassName asClass equals: LcsAccessorSlotBuilder slotClass.
	self assert: self subject jobSteps hasNoJobSteps.
	self assert: self subject refactorings isEmpty.
	self assert: self subject state equals: 'Initial'.
]

{ #category : #tests }
LcsAccessorSlotBuilderTest >> testInstallingSlot [
	self subject: (
		LcsAccessorSlotBuilder new
			slotClassName: LcsStringSlot name;
			targetClassName: LxxPrototypeSystem name;
			addSlotType: LxxPerson name ;
			slotName: 'foos';
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel
]
