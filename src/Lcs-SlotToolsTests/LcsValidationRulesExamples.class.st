Class {
	#name : 'LcsValidationRulesExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValidationRulesExamples >> newRules [
	<gtExample>
	| rules |
	rules := LcsValidationRules new.
	self assert: rules collection isEmpty.
	self assert: rules parent isNil.
	self assert: (rules collection isKindOf: OrderedCollection).
	self assert: (rules validate: Date today).
	self assert: ( rules validate: (Date today addDays: 1)). 
	self assert: (rules validate: 'xxx').
	^ rules
]

{ #category : 'examples' }
LcsValidationRulesExamples >> rulesWithDateOnOrAfterTodayRule [
	<gtExample>
	| rule rules |
	rule := LcsValidationRuleExamples new dateOnOrAfterTodayRule.
	rules := self newRules.
	rules addRule: rule.
	self assert: (rules validate: Date today).
	self
		should: [ rules validate: (Date today subtractDays: 1) ]
		raise: LcsSlotValidationError.
	^ rules
]

{ #category : 'examples' }
LcsValidationRulesExamples >> rulesWithDateOnOrBeforeTodayRule [
	<gtExample>
	| rules |
	rules := self newRules.
	rules addRule: LcsValidationRuleExamples new dateOnOrBeforeTodayRule.
	self assert: (rules validate: Date today).
	self should: [ rules validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	^ rules
]

{ #category : 'examples' }
LcsValidationRulesExamples >> rulesWithRuleAddedAndThenRemoved [
	<gtExample>
	| rule rules |
	rules := self rulesWithDateOnOrAfterTodayRule.
	rule := rules collection at: 1.
	rules removeRule: rule.
	self assert: rules collection isEmpty.
	^ rules
]

{ #category : 'examples' }
LcsValidationRulesExamples >> twoDateRules [
	<gtExample>
	| rules |
	rules := self newRules.
	rules addRule: LcsValidationRuleExamples new dateOnOrAfterTodayRule.
	rules addRule: LcsValidationRuleExamples new dateOnOrBeforeTodayRule.
	self assert: (rules validate: Date today).
	self should: [ rules validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	self should: [ rules validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError. 
	^ rules
]
