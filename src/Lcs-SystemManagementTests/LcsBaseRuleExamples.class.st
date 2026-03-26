Class {
	#name : 'LcsBaseRuleExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsBaseRuleExamples >> newRule [
	<gtExample>
	| rule |
	rule := LcsBaseRule new.
	self assert: rule conditionBlock printString equals:'[ :value | true ]'.
	self assert: rule description equals:''.
	self assert: rule errorMessage isNil.
	self assert: rule validationErrorMessage equals: ''.
	^ rule
]

{ #category : 'examples' }
LcsBaseRuleExamples >> ruleWithSmalltalkErrorInConditionBlock [
	<gtExample>
	| rule |
	rule := self newRule.
	rule conditionBlock: [ :value | (value + 3) < 7 ].
	self should: [ rule validate: 'abd' ] raise: LcsSlotValidationExecutionError.
	^ rule
]

{ #category : 'examples' }
LcsBaseRuleExamples >> slotValidationExecutionError [
	<gtExample>
	<noTest>
	| rule |
	rule := self ruleWithSmalltalkErrorInConditionBlock.
	self should: [ rule validate: 'abd' ] raise: LcsSlotValidationExecutionError.
	^ rule validate: 'abd'
]
