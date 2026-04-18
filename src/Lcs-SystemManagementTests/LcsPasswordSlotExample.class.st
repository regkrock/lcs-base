Class {
	#name : 'LcsPasswordSlotExample',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPasswordSlotExample >> auditorOnSlotWithNilPassword [
	<gtExample>
	| slot auditor |
	slot := self newSlot.
	auditor := LcsConditionsValidator newOn: self.
	slot audit: auditor currentValue: nil context: 'xxxx'.
	self assert: auditor errorDescriptions size = 1.
	self assert: auditor errorDescriptions first equals: 'Attempt to update password  slot("LcsPasswordSlot") in "nil" with: nil'.
	^ auditor
]

{ #category : 'examples' }
LcsPasswordSlotExample >> auditorOnSlotWithNullPassword [
	<gtExample>
	| slot auditor |
	slot := self newSlot.
	auditor := LcsConditionsValidator newOn: self.
	slot audit: auditor currentValue: '' context: 'xxxx'.
	self assert: auditor errorDescriptions size = 1.
	self assert: auditor errorDescriptions first equals:'Null is not allowed'.
	^ auditor
]

{ #category : 'examples' }
LcsPasswordSlotExample >> auditorOnSlotWithValidPasssword [
	<gtExample>
	| slot auditor |
	slot := self newSlot.
	auditor := self newAuditor.
	slot
		audit: auditor
		currentValue: 'abcde#3$A'
		context: 'xxxx'.
	self assert: auditor errorDescriptions isEmpty.
	^ auditor
]

{ #category : 'examples' }
LcsPasswordSlotExample >> newAuditor [
	^ LcsConditionsValidator newOn: self
]

{ #category : 'examples' }
LcsPasswordSlotExample >> newSlot [
	<gtExample>
	| slot |
	slot := LcsPasswordSlot new.
	self assert: slot slotName equals: 'password'.
	self assert: slot allowInitialNull.
	self assert: (slot slotTypes includes: String).
	self assert: slot slotTypeRules collectionSize = 2.
	self assert: slot validationRules collectionSize = 2.
	^ slot
]

{ #category : 'examples' }
LcsPasswordSlotExample >> validateSlotTypeRulesForSlot [
	<gtExample>
	| slot rule |
	slot := self newSlot.

	rule := slot slotTypeRules ruleWithDescription: LcsAllowNullSlotTypeRule new description.
	self assert: (rule isKindOf: LcsAllowNullSlotTypeRule).
	self 
		assert: (rule audit: '' context: 'xxxx') 
		description: 'Null string is allowed at initialization'.
	self 
		deny: (rule audit: 'abc' context: 'xxxx') 
		description: 'Returns false because this rule is specifically for initializing the value with an empty string'.
	self 
		deny: (rule audit: nil context: 'xxxx') 
		description: 'Nil not allowed'.
	self 
		deny: (rule validate: 'abc' context: 'xxxx' oldValue: '') 
		description: 'Returns false because this rule is specifically for initializing the value with an empty string'.
	self assert: (rule validate: '' context: 'xxxx' oldValue: nil) description: 'Fails as expected'.

	rule := slot slotTypeRules ruleWithDescription: 'Instance''s class not in slot types list'.
	self assert: (rule isKindOf: LcsInstanceIsKindOfSlotTypesRule).
	self 
		assert: (rule audit: 'xxx' context: 'xxxx') 
		description: 'Value is of the correct type'.
	self 
		assert: (rule audit: '' context: 'xxxx' ) 
		description: 'Value is of the correct type'.
	self 
		should: [ rule audit: nil context: 'xxxx' ] 
		raise: LcsInvalidSlotTypeError 
		description: 'Nil is not of type String'.
	self 
		assert: (rule validate: 'xxx' context: 'xxxx' oldValue: nil) 
		description: 'This is the right type'.
	self 
		assert: (rule validate: '' context: 'xxxx' oldValue: nil) 
		description: 'This is the right type.'.
	self 
		should: [ rule validate: nil context: 'xxxx' oldValue: '' ] 
		raise: LcsInvalidSlotTypeError 
		description: 'Fails as expected'.
	^ slot

]

{ #category : 'examples' }
LcsPasswordSlotExample >> validateValidationRulesForSlot [
	<gtExample>
	| slot rule |
	slot := self newSlot.
	rule := slot validationRules ruleWithDescription: 'Is Null Valid For Initialization Rule'.
	self assert: (rule isKindOf: LcsAllowInitialNullRule).
	self assert: rule validationErrorMessage equals: 'Attempt to initialize slot with null when in a state other than initialization'.

	self 
		assert: (rule validate: '' context: 'xxxx' oldValue: nil "LcsApplicationEnvironment undefinedObject") 
		description: 'This is the right type'.
	self 
		should: [ rule validate: '' context: 'xxxx' oldValue: '' ] 
		raise: LcsSlotValidationError
		description: 'Empty string is only allowed to replace nil'.
	self 
		deny: (rule validate: 'Abcd12efg#' context: 'xxxx' oldValue: '') 
		description: 'Fails because this rule is for initial value of null string'.
	self 
		deny: (rule validate: 250 context: 'xxxx' oldValue: '') 
		description: 'Fails because this rule is for initial value of null string'.

	self 
		should: [ rule audit: '' context: 'xxxx' ]
		raise: LcsSlotValidationError
		description: 'From an audit perspective, an empty string is 
						an invalid value when the object is persisted'.
	self 
		deny: ( rule audit: nil context: 'xxxx' ) 
		description: 'Invalid type but for this rule it evaluates to true'.
	
	rule := slot validationRules ruleWithDescription: 'Password is required'.
	self assert: (rule isKindOf: LcsValidationRule).
	self assert: rule validationErrorMessage equals: 'Password must be least 8 characters long and include at least one number, one special character (+-/\*~<>=@,%|&?!·÷±×) and one uppercase character'.

	self 
		assert: (rule audit: 'Abcd12efg#' context: 'xxxx') 
		description: 'This is the right type'.
	self 
		should: [ rule audit: '' context: 'xxxx' ] 
		raise: LcsSlotValidationError 
		description: 'Invalid type for persistence of the domain object'.
	self 
		should: [ rule audit: nil context: 'xxxx' ] 
		raise: LcsSlotValidationError 
		description: 'Invalid type'.
	^ slot

]
