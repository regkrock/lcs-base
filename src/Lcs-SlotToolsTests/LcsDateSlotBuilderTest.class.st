Class {
	#name : #LcsDateSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #setUp }
LcsDateSlotBuilderTest >> tearDown [
	super tearDown.
	LxxPerson removeInstVar: 'date'
]

{ #category : #tests }
LcsDateSlotBuilderTest >> testCreation [
	self assert: LcsDateSlotBuilder slotClass equals: LcsDateSlot
]

{ #category : #tests }
LcsDateSlotBuilderTest >> testDateChangeValidation [
	| person |
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today addDays: 10];
			addValidationCondition: [ :newDate :domainObject :oldValue |  
				newDate < Date today] description: 'Date must be >= today';
			addValidationCondition: [ :newDate :domainObject :oldValue |  
				newDate > (Date today addDays: 19)] description: 'Date must be < 20 days in the future';
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation.
	self subject updateSlotModel.
	
	self currentSystem applyChanges.
	
	person := LxxPerson new.
	self assert: person date equals: (Date today addDays: 10).
	self should: [ person date: (Date today subtractDays: 1) ] raise: LcsSlotValidationError .
	self shouldnt: [ person date: Date today] raise: LcsSlotValidationError .
	self shouldnt: [ person date: (Date today addDays: 19) ] raise: LcsSlotValidationError.
	self should: [ person date: (Date today addDays: 20) ] raise: LcsSlotValidationError
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
LcsDateSlotBuilderTest >> testInstallingSlotWithValidationBlocks [
	| slotDefinitionMethodBuilder |
	self subject: (
		LcsDateSlotBuilder new
			slotName: 'date';
			targetClassName: LxxPerson name;
			initialValueBlock: [ Date today addDays: 10 ];
			addValidationCondition: [ :newDate :domainObject :oldValue | newDate < Date today] description: 'Date must be >= today';
			addValidationCondition: [ :newDate :domainObject :oldValue | newDate > (Date today addDays: 19)] description: 'Date must be < 20 days in the future';
			yourself).
	self subject buildJobSteps.
	
	slotDefinitionMethodBuilder := (self subject jobSteps collection at: 2).
	
	self assert: slotDefinitionMethodBuilder  slotDefinitionSource equals: 'dateSlotDefinition
	<slotDefinition>
	^ LcsDateSlot new
		addValidationCondition: [ :newDate :domainObject :oldValue | newDate < Date today] description: ''Date must be >= today'';
		addValidationCondition: [ :newDate :domainObject :oldValue | newDate > (Date today addDays: 19)] description: ''Date must be < 20 days in the future'';
		slotName: ''date'';
		initialValueBlock: [ Date today addDays: 10 ];
		yourself'

]
