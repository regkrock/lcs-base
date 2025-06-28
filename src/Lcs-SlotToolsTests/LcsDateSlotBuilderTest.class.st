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

{ #category : #'as yet unclassified' }
LcsDateSlotBuilderTest >> testInstallingSlotWithValidationBlocks [
	| person |
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today addDays: 10 ];
			addValidationCondition: [ :value | value < Date today] description: 'Date must be >= today';
			addValidationCondition: [ :value | value > Date today] description: 'Date must be < 20 days in the future';
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	person := LxxPerson new.
	self assert: person date equals: (Date today addDays: 10).
	self should: [ person date: (Date today subtractDays: 1) ] raise: LcsSlotValidationError .
	self should: [ person date: (Date today addDays: 21) ] raise: LcsSlotValidationError .

]
