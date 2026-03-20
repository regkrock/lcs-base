Class {
	#name : 'LcsSlotTypeRulesExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> newRules [
	<gtExample>
	| rules |
	rules := LcsSlotTypeRules new.
	self assert: rules collection isEmpty.
	self assert: rules parent isNil.
	self assert: (rules collection isKindOf: OrderedCollection).
	self should: [ rules validate: Date today ] raise: LcsInvalidSlotTypeError.
	self should: [ rules validate: nil ] raise: LcsInvalidSlotTypeError.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> noRulesError [
	<gtExample>
	<noTest>
	| rules |
	rules := self newRules.
	self assert: rules collection isEmpty.
	rules validate: Date today.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> numberSlotTypeRules [
	<gtExample>
	<noTest>
	| rules slot |
	slot := LcsNumberSlotExamples new newSlot.
	rules := slot slotTypeRules.
	self assert: rules hasElements.
	self assert: rules collection size = 1.
	self assert: (rules collection any isKindOf: LcsInstanceIsKindOfSlotTypesRule).
	self assert: (rules validate: 1).
	self assert: (rules validate: 1 context: nil).
	self should: [ rules validate: 'a' ] raise: LcsInvalidSlotTypeError.
	self should: [ rules validate: nil ] raise: LcsInvalidSlotTypeError.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> numberSlotTypeRulesWithInvalidTypeError [
	<gtExample>
	<noTest>
	| rules |
	rules := self numberSlotTypeRules.
	rules validate: 'a'.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> numberTypeRulesAndNilIsAllowed [
	<gtExample>
	<noTest>
	| rules slot |
	slot := LcsNumberSlotExamples new newSlot.
	self should: [ rules validate: nil ] raise: Error.
	slot beAllowNil.
	rules := slot slotTypeRules.
	self assert: rules collection size = 2.
	rules validate: nil.
	self assert: (rules validate: 1).
	self should: [ rules validate: 'a' ] raise: LcsInvalidSlotTypeError.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> numberTypeRulesAndNilIsNotAllowed [
	<gtExample>
	<noTest>
	| rules slot |
	slot := LcsNumberSlotExamples new newSlot.
	self should: [ rules validate: nil ] raise: Error.
	slot beAllowNil.
	rules := slot slotTypeRules.
	self assert: rules collection size = 2.
	rules validate: nil.
	self assert: (rules validate: 1).
	self should: [ rules validate: 'a' ] raise: LcsInvalidSlotTypeError.
	slot beDisallowNil.
	self assert: rules collection size = 1.
	self should: [ rules validate: nil ] raise: LcsInvalidSlotTypeError.
	self assert: (rules validate: 1).
	self should: [ rules validate: 'a' ] raise: LcsInvalidSlotTypeError.
	^ rules
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> rulesWithInstanceIsMemberOfSlotTypeRuleButNoSlot [
	<gtExample>
	| rules |
	rules := self newRules.
	rules addRule: (LcsInstanceIsKindOfSlotTypesRule new).
	self assert: rules hasElements.
	self assert: rules collection size = 1.
	self assert: (rules collection any isKindOf: LcsInstanceIsKindOfSlotTypesRule).
	self should: [ rules validate: 1 ] raise: LcsInvalidSlotTypeError
]

{ #category : 'examples' }
LcsSlotTypeRulesExamples >> rulesWithInstanceIsMemberOfSlotTypeRuleButNoSlot_InvalidTypeError [
	<gtExample>
	<noTest>
	| rules |
	rules := self newRules.
	rules addRule: (LcsInstanceIsKindOfSlotTypesRule new).
	self assert: rules hasElements.
	self assert: rules collection size = 1.
	self assert: (rules collection any isKindOf: LcsInstanceIsKindOfSlotTypesRule).
	rules validate: 1.
	^ rules
]
