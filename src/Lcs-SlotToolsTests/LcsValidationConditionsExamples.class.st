Class {
	#name : 'LcsValidationConditionsExamples',
	#superclass : 'LcsExamples',
	#traits : 'LtApplicationEnvironmntExamplesManagement',
	#classTraits : 'LtApplicationEnvironmntExamplesManagement classTrait',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValidationConditionsExamples >> dateSlotWithValidationCondition [
	<gtExample>
	| slot |
	slot := LcsDateSlot new.
	slot addValidationCondition: LcsValidationConditionExamples new dateValidationCondition.
	self assert: (slot validate: Date today) hasNoErrors.
	self should: [ slot validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError.
	^ slot
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> newValidationConditions [
	<gtExample>
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self assert: validationConditions collection isEmpty.
	self assert: validationConditions parent isNil.
	self assert: (validationConditions collection isKindOf: OrderedCollection).
	^ validationConditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validConditionsBlockWithDateCondition [
	<gtExample>
	| validationDescription conditionBlock conditions |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :value | Date today < value ].
	conditions := LcsValidationConditions new.
	conditions addValidationConditionBlock: conditionBlock description: validationDescription.
	conditions validate: Date today.
	^ conditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validationConditionsValidationConditionRemoved [
	<gtExample>
	| validationCondition validationConditions |
	validationConditions := self validationConditionsWithOneCondition.
	validationCondition := validationConditions collection at: 1.
	validationConditions removeValidationCondition: validationCondition.
	self assert: validationConditions collection isEmpty.
	^ validationConditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validationConditionsWithOneCondition [
	<gtExample>
	| validationDescription validationCondition conditionBlock validationConditions |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :newDate :parentDomainObject :oldValue |  Date today < newDate ].
	validationConditions := self newValidationConditions.
	validationConditions addValidationConditionBlock: conditionBlock description: validationDescription.
	validationCondition := validationConditions validationConditionWithDescription: validationDescription.
	self assert: validationCondition validationDescription equals: validationDescription.
	self assert: validationCondition conditionBlock equals: conditionBlock.
	self assert: validationConditions collection size equals: 1.
	^ validationConditions
]
