Class {
	#name : 'LcsValidationRuleExamples',
	#superclass : 'LcsExamples',
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsValidationRuleExamples >> alwaysFalseRule [
	<gtExample>
	| rule |
	rule := self newRule.
	rule conditionBlock: [ :value :parentDomainObject | false ].
	self should: [ rule validate: true ] raise: LcsSlotValidationError.
	self should: [ rule validate: false ] raise: LcsSlotValidationError.
	self should: [ rule validate: true context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ rule validate: false context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ rule validate: false context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self should: [ rule validate: true context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self assert: rule asCreationString equals: 'LcsValidationRule new
	conditionBlock: [ :value :parentDomainObject | false ];
	yourself'.	
	^ rule
]

{ #category : 'tests' }
LcsValidationRuleExamples >> birthDateRule [
	<gtExample>
	| rule description conditionBlock |
	description :=  'Age must be between 0 and 120 years'.
	conditionBlock := [ :newDate | ((newDate year) > (Date today year - 120)) and: [ newDate <= Date today ] ].
	rule := self newRule
					description: description;
					conditionBlock: conditionBlock.

	self assert: (rule validate: Date today).
	self assert: (rule validate: (Date newDay: 31 month: 12 year: (Date today year - 119))).
	self should: [ rule validate: (Date newDay: 31 month: 12 year: (Date today year - 120)) ] raise: LcsSlotValidationError.
	self should: [ rule validate: (Date today addDays: 1) ] raise: LcsSlotValidationError.
	self assert: rule asCreationString equals: 'LcsValidationRule new
	description: ''Age must be between 0 and 120 years'';
	conditionBlock: [ :newDate | ((newDate year) > (Date today year - 120)) and: [ newDate <= Date today ] ];
	yourself'.	

	^ rule
]

{ #category : 'tests' }
LcsValidationRuleExamples >> dateOnOrAfterTodayRule [
	<gtExample>
	| rule description conditionBlock |
	description :=  'Date must be today or beyond'.
	conditionBlock := [ :newDate | newDate >= Date today ].
	rule := self newRule
					description: description;
					conditionBlock: conditionBlock.
	self assert: rule conditionBlock == conditionBlock.
	self assert: rule description == description.
	self assert: rule parent isNil.

	self assert: (rule validate: Date today).
	self should: [ rule validate: 'xxxx' ] raise: Error description: 'Comparison execution error'.
	self should: [ rule validate: (Date today subtractDays: 1) ] raise: LcsSlotValidationError.
	self assert: rule asCreationString equals: 'LcsValidationRule new
	description: ''Date must be today or beyond'';
	conditionBlock: [ :newDate | newDate >= Date today ];
	yourself'.
	^ rule
]

{ #category : 'tests' }
LcsValidationRuleExamples >> dateOnOrBeforeTodayRule [
	<gtExample>
	| rule description conditionBlock |
	description :=  'Date must be on or before today'.
	conditionBlock := [ :newDate | newDate <= Date today ].
	rule := self newRule
					description: description;
					conditionBlock: conditionBlock.
	self assert: rule conditionBlock == conditionBlock.
	self assert: rule description == description.
	self assert: rule parent isNil.

	self assert: (rule validate: Date today).
	self should: [ rule validate: 'xxxx' ] raise: Error description: 'Comparison execution error'..
	self should: [ rule validate: (Date today addDays: 1) ] raise: LcsSlotValidationError.
	self assert: rule asCreationString equals: 'LcsValidationRule new
	description: ''Date must be on or before today'';
	conditionBlock: [ :newDate | newDate <= Date today ];
	yourself'.

	^ rule
]

{ #category : 'tests' }
LcsValidationRuleExamples >> newRule [
	<gtExample>
	| rule |
	rule := LcsValidationRule new.
	self assert: rule conditionBlock displayString equals: '[ :value | true ]'.
	self assert: rule description equals: LcsValidationRule new defaultDescription.
	self assert: rule errorMessage isNil.
	self assert: rule parent isNil.
	self assert: (rule validate: true) equals: true.
	self assert: (rule validate: 'xxxx') equals: true. 
	rule conditionBlock: [ :value :parentDomainObject | value == false ].
	self should: [ rule validate: true ] raise: LcsSlotValidationError.
	self shouldnt: [ rule validate: false ] raise: LcsSlotValidationError.
	self should: [ rule validate: true context: 'aString' ] raise: LcsSlotValidationError.
	self shouldnt: [ rule validate: false context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ rule validate: true context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self shouldnt: [ rule validate: false context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self assert: rule asCreationString equals: 'LcsValidationRule new
	conditionBlock: [ :value :parentDomainObject | value == false ];
	yourself'.	
	^ rule
]

{ #category : 'tests' }
LcsValidationRuleExamples >> ruleCausingMessageUnderstoodError [
	<gtExample>
	| rule |
	rule := self newRule
					description: 'Value >= 10';
					conditionBlock: [ :value :parentDomainObject | value + 5 < 10 ].
	self 
		should: [ rule validate: true context: 'aString' ]  
		raise: MessageNotUnderstood.
	self 
		shouldnt: [ rule validate: 2 context: 'aString' ] 
		raise: MessageNotUnderstood.
	^ rule
]

{ #category : 'scripter' }
LcsValidationRuleExamples >> ruleScripter [
	"<gtExample>
	<return: #BlScripter>
	self subjectScripter: (self
			scripterWithModel: [ self newValidationCondition ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ]).

	self
		assert: self subjectScripter
		model: self subjectScripter model
		acceptEnabled: false
		cancelEnabled: true.

	^ self subjectScripter"
]

{ #category : 'tests' }
LcsValidationRuleExamples >> testMagritteForm [
	"<gtExample>"
	"<return: #BlScripter>"
	"| aValidationDescriptionId aConditionBlockId anAcceptId aCancelId |
	
	self subjectScripter: self validationConditionScripter.

	aValidationDescriptionId := GtMagritteFieldElementId new description: self subjectScripter model validationDescriptionDescription.
	aConditionBlockId := GtMagritteFieldElementId new description: self subjectScripter model conditionBlockDescription.
	anAcceptId := GtMagritteActionElementId new description: self subjectScripter model magritteAcceptAction.
	aCancelId := GtMagritteActionElementId new description: self subjectScripter model magritteCancelAction.

	self subjectScripter
		substeps: 'Change validation description value'
		do: [ :aStep | 

			aStep requestFocus
				// aValidationDescriptionId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: 'invalid condition description';
						// aValidationDescriptionId ]."

			"aStep
				assertStep: [ :s | 
					s
						label: 'Assert model validation description value';
						value: [ :aModel | aModel validationDescription ] equals: [ 'invalid condition description' ];
						onModel ]."
						
			"self
				assert: aStep
				model: self subjectScripter model
				acceptEnabled: false
				cancelEnabled: true ].

	self subjectScripter
		substeps: 'Change condition block value'
		do: [ :aStep | 

			aStep requestFocus
				// aConditionBlockId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: 'value size < 1';
						// aConditionBlockId ].
						
			self
				assert: aStep
				model: self subjectScripter model
				acceptEnabled: true
				cancelEnabled: true ].
				
	self subjectScripter
		substeps: 'Accept changed values'
		do: [ :aStep | 
			aStep clickStep: [ :s | s // .anAcceptId ].

			self
				assert: aStep
				model: self subjectScripter model
				acceptEnabled: false
				cancelEnabled: false.
				
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert model condition block value';
						value: [ :aModel | aModel validationDescription ] equals: [ 'invalid condition description' ];
						onModel ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert model condition block value';
						value: [ :aModel | aModel conditionBlock asString ] equals: [ '[ :value :domainObject :oldValue | value size < 1 ]' ];
						onModel ]].

	^ self subjectScripter"
]
