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
LcsValidationConditionsExamples >> dateOnOrAfterTodayConditions [
	<gtExample>
	| conditions |
	conditions := LcsValidationConditions new.
	conditions addValidationCondition: LcsValidationConditionExamples new dateOnOrAfterTodayValidationCondition.
	self assert: (conditions validate: Date today).
	self should: [ conditions validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError.
	^ conditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> dateOnOrBeforeTodayConditions [
	<gtExample>
	| conditions |
	conditions := LcsValidationConditions new.
	conditions addValidationCondition: LcsValidationConditionExamples new dateOnOrBeforeTodayValidationCondition.
	self assert: (conditions validate: Date today).
	self should: [ conditions validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	^ conditions
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
LcsValidationConditionsExamples >> twoValidationConditions [
	<gtExample>
	| conditions |
	conditions := LcsValidationConditions new.
	conditions addValidationCondition: LcsValidationConditionExamples new dateOnOrAfterTodayValidationCondition.
	conditions addValidationCondition: LcsValidationConditionExamples new dateOnOrBeforeTodayValidationCondition.
	self assert: (conditions validate: Date today).
	self should: [ conditions validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	self should: [ conditions validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError. 
	^ conditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validConditionsBlockWithDateCondition [
	<gtExample>
	| condition conditions |
	condition := LcsValidationConditionExamples new
			dateOnOrAfterTodayValidationCondition.
	conditions := self newValidationConditions.
	conditions addValidationCondition: condition.
	self assert: (conditions validate: Date today).
	self
		should: [ conditions validate: (Date today subtractDays: 1) ]
		raise: LcsSlotValidationError.
	^ conditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validateEmptyCollectionOrConditions [
	<gtExample>
	| conditions |
	conditions := LcsValidationConditions new.
	self assert: (conditions validate: Date today).
	self assert: ( conditions validate: (Date today addDays: 1)). 
	self assert: (conditions validate: 'xxx').
	^ conditions
]

{ #category : 'examples' }
LcsValidationConditionsExamples >> validationConditionsValidationConditionRemoved [
	<gtExample>
	| validationCondition validationConditions |
	validationConditions := self validConditionsBlockWithDateCondition.
	validationCondition := validationConditions collection at: 1.
	validationConditions removeValidationCondition: validationCondition.
	self assert: validationConditions collection isEmpty.
	^ validationConditions
]
