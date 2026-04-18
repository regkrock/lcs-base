Class {
	#name : 'LcsValidationRulesExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValidationRulesExamples >> initialNilAndTwoDateRules [
	<gtExample>
	| rules dateRules |
	rules := self newRules.
	rules addRule: LcsAllowInitialNilRule new.
	dateRules := rules addRule: (LcsValidationRules newAndRules description: 'Validate Date'; yourself).
	dateRules addRule: LcsValidationRuleExamples new dateOnOrAfterTodayRule.
	dateRules addRule: LcsValidationRuleExamples new dateOnOrBeforeTodayRule.
	self assert: rules collection size = 2.
	self assert: dateRules collection size = 2.
	self assert: (rules validate: Date today).
	self should: [ rules validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	self should: [ rules validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError. 
	self assert: rules asCreationString equals: 
'LcsValidationRules new
	addRule: (
		LcsAllowInitialNilRule new);
	addRule: (
		LcsValidationRules new
			beAndEvaluationType;
			description: ''Validate Date'';
			addRule: (
				LcsValidationRule new
					description: ''Date must be today or beyond'';
					conditionBlock: [ :newDate | newDate >= Date today ];
					yourself);
			addRule: (
				LcsValidationRule new
					description: ''Date must be on or before today'';
					conditionBlock: [ :newDate | newDate <= Date today ];
					yourself);
			yourself);
	yourself'.
	^ rules
]

{ #category : 'examples' }
LcsValidationRulesExamples >> newAndRules [
	<gtExample>
	| rules |
	rules := LcsValidationRules newAndRules.
	self assert: rules collection isEmpty.
	self assert: rules parent isNil.
	self assert: (rules collection isKindOf: OrderedCollection).
	self assert: (rules validate: Date today).
	self assert: ( rules validate: (Date today addDays: 1)). 
	self assert: (rules validate: 'xxx').
	self assert: rules description isEmpty.
	self assert: rules asCreationString equals: 
'LcsValidationRules new
	beAndEvaluationType;
	yourself'.
	^ rules
]

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
	self assert: rules asCreationString equals: 'LcsValidationRules new'.
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
	self assert: rules asCreationString equals: 
'LcsValidationRules new
	addRule: (
		LcsValidationRule new
			description: ''Date must be today or beyond'';
			conditionBlock: [ :newDate | newDate >= Date today ];
			yourself);
	yourself'.
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
	rules := self newAndRules.
	rules addRule: LcsValidationRuleExamples new dateOnOrAfterTodayRule.
	rules addRule: LcsValidationRuleExamples new dateOnOrBeforeTodayRule.
	self assert: rules collection size = 2.
	self assert: (rules validate: Date today).
	self should: [ rules validate: (Date today addDays: 1) ] raise: LcsSlotValidationError. 
	self should: [ rules validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError. 
	self assert: rules asCreationString equals: 
'LcsValidationRules new
	beAndEvaluationType;
	addRule: (
		LcsValidationRule new
			description: ''Date must be today or beyond'';
			conditionBlock: [ :newDate | newDate >= Date today ];
			yourself);
	addRule: (
		LcsValidationRule new
			description: ''Date must be on or before today'';
			conditionBlock: [ :newDate | newDate <= Date today ];
			yourself);
	yourself'.
	^ rules
]
