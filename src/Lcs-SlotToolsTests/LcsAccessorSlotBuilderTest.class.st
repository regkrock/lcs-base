Class {
	#name : 'LcsAccessorSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testAddingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							validationDescription: 'Test';
							conditionBlock: [ :value | ];
							yourself.
	self subject: LcsAccessorSlotBuilder new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collectionSize equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testAddingValidationConditionAndDescription [
	self subject: LcsAccessorSlotBuilder new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testAllowNil [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject allowNil == false.
	self deny: self subject isNilAllowed.
	self subject beAllowNil.
	self assert: self subject allowNil == true.
	self assert: self subject isNilAllowed
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testAllowNilDescription [
	| description |
	self subject: LcsAccessorSlotBuilder new.
	description := self subject allowNilDescription.
	self assert: (description read: self subject) = false
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testCreation [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject validationConditions hasNoElements.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotClassName asClass equals: LcsAccessorSlotBuilder slotClass.
	self assert: self subject jobSteps hasNoJobSteps.
	self assert: self subject refactorings isEmpty.
	self assert: self subject state equals: 'Initial'.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testInitalValueSetToNil [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject initialValueBlock printString equals: '[ ]'.
	self subject populateFrom: LcsScaledDecimalSlot name.
	self assert: self subject initialValueBlock printString equals: '[ :parentDomainObject :slot | 0 asScaledDecimal: slot numberOfDecimals ]'.
	self subject initialValueBlockDescription write: 'nil' to: self subject.
	self assert: self subject initialValueBlock printString equals: '[ :parentDomainObject :slot | nil ]'.
	self assert: (self subject initialValueBlock cull: self cull: self) isNil
]

{ #category : 'tests' }
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

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testPrevalidationTransformBlockDescription [
	| description |
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject prevalidationTransformBlock asString equals: '[  ]'.
	
	description := self subject prevalidationTransformBlockDescription.
	self assert: (description read: self subject) equals: ''.
			
	description write: '0' to: self subject.
	self assert: (description read: self subject) equals: '0'.

	self assert: self subject prevalidationTransformBlock asString equals: '[ :value :slot | 0 ]'
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testRemovingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							validationDescription: 'Test';
							conditionBlock: [ :value | ];
							yourself.

	self subject: LcsAccessorSlotBuilder new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationCondition: validationCondition.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testRemovingValidationConditionViaDescription [
	self subject: LcsAccessorSlotBuilder new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationConditionWithDescription: 'Test'.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testRequried [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject required == false.
	self subject required: true.
	self assert: self subject required == true.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testSlotTypes [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotTypes class == OrderedCollection.
	self subject slotTypes: Array new.
	self assert: self subject slotTypes class == Array
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testSlotTypesDescription [
	| description |
	self subject: LcsAccessorSlotBuilder new.
	self subject slotTypes: { String }.
	description := self subject slotTypesDescription.
	self assert: (description read: self subject) equals: #(#String).
	description write: #(#String #Integer) to: self subject.
	self assert: self subject slotTypes equals: { String. Integer}.
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testUpdatingInitialValueBlockViaMagritteDescription [
	| description |
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject initialValueBlock asString equals: '[ ]'.
	
	description := self subject initialValueBlockDescription.
	self assert: (description read: self subject) = ''.
			
	description write: '0' to: self subject.
	self assert: (description read: self subject) equals: '0'.

	self assert: self subject initialValueBlock asString equals: '[ :parentDomainObject :slot | 0 ]'
]

{ #category : 'tests' }
LcsAccessorSlotBuilderTest >> testValidationConditions [
	self subject: LcsAccessorSlotBuilder new.
	self assert: self subject validationConditions class == LcsValidationConditions.
	self assert: self subject validationConditions hasNoElements.
]
