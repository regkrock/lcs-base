Class {
	#name : 'LcsAllowNilSlotTypeRuleExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAllowNilSlotTypeRuleExamples >> conditionWithNilAllowed [
	<gtExample>
	| rule numberSlot|
	rule := self newRule.
	numberSlot := LcsNumberSlotExamples new newSlot.
	self should: [ rule validate: nil ] raise: LcsInvalidSlotTypeError.
	numberSlot slotTypeRules addFirstRule: rule.
	numberSlot  propertyAt: 'allowNil' put: true.
	self shouldnt: [ rule validate: nil ] raise: LcsInvalidSlotTypeError.
	^ rule
]

{ #category : 'examples' }
LcsAllowNilSlotTypeRuleExamples >> newRule [
	<gtExample>
	| rule |
	rule := LcsAllowNilSlotTypeRule new.
	self assert: rule description equals: LcsAllowNilSlotTypeRule new defaultDescription.
	self assert: rule conditionBlock printString equals: LcsAllowNilSlotTypeRule new defaultConditionBlock printString.
	self assert: rule errorMessage equals: LcsAllowNilSlotTypeRule new defaultErrorMessage.
	^ rule
]

{ #category : 'examples' }
LcsAllowNilSlotTypeRuleExamples >> nilNotAllowedError [
	<gtExample>
	<noTest>
	| rule numberSlot|
	rule := self newRule.
	numberSlot := LcsNumberSlotExamples new newSlot.
	numberSlot addSlotTypeRule: rule.
	rule validate: nil.
	^ rule
]

{ #category : 'examples' }
LcsAllowNilSlotTypeRuleExamples >> ruleWithNilNotAllowed [
	<gtExample>
	| rule numberSlot|
	rule := self newRule.
	numberSlot := LcsNumberSlotExamples new newSlot.
	numberSlot beAllowNil.
	numberSlot addSlotTypeRule: rule.
	self shouldnt: [ rule validate: nil ] raise: LcsSlotValidationError.
	self assert: (rule validate: nil).
	^ rule
]
