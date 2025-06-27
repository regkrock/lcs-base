Class {
	#name : #LcsDateSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsDateSlotBuilderTest >> testCreation [
	self assert: LcsDateSlotBuilder slotClass equals: LcsDateSlot
]

{ #category : #'as yet unclassified' }
LcsDateSlotBuilderTest >> testInstallingSlot [
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	self assert: (LxxPerson hasSlotDefinitionNamed: 'date') 
]

{ #category : #'as yet unclassified' }
LcsDateSlotBuilderTest >> testInstallingSlotWithInitialValueBlockOverriden [
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today subtractDays: 10 ];
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	self assert: LxxPerson new date equals: (Date today subtractDays: 10)
]
