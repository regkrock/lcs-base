Class {
	#name : 'LcsStringSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStringSlotExamples >> lastNameSlotAllowingInitialNullAndRequiring2To10Characters [
	<gtExample>
	| slot subrules |
	slot := self lastNameSlotAllowingInitialNullAndRequiringAtLeast2CharactersAfterThat.
	slot beAllowInitialNull.
	self assert: slot validationRules collectionSize = 2.
	subrules := slot validationRules collection at: 2.
	self assert: subrules collectionSize = 1.
	subrules
		addRuleBlock: [ :value :parentDomainObject :oldValue | value size <= 10 ] 
		description: 'Maximum 10 characters'.
	self assert: slot validationRules collectionSize = 2.
	self assert: subrules collectionSize = 2.

	self assert: (slot validate: 'ab' context: nil oldValue: nil).
	self 
		should: [ slot validate: 'a' context: nil oldValue: nil ] 
		raise: LcsSlotValidationError 
		description: 'String is too short'.
	self 
		should: [ slot validate: 'kasdjflasjdflasdfksdfsad' context: nil oldValue: nil ] 
		raise: LcsSlotValidationError 
		description: 'String is too long'.
	^ slot
]

{ #category : 'examples' }
LcsStringSlotExamples >> lastNameSlotAllowingInitialNullAndRequiringAtLeast2CharactersAfterThat [
	<gtExample>
	| slot subrules |
	slot := self lastNameSlotAllowingNull.
	slot beAllowInitialNull.
	self assert: slot validationRules collectionSize = 1.
	subrules := slot validationRules addRule: (LcsValidationRules newAndRules).
	subrules 
		addRuleBlock: [ :value :parentDomainObject :oldValue | value size >= 2 ] 
		description: 'Minimum 2 characters'.
	self assert: slot validationRules collectionSize = 2.
	self assert: subrules collectionSize = 1.

	self assert: (slot validate: 'ab' context: nil oldValue: nil).
	self 
		should: [ slot validate: 'a' context: nil oldValue: nil ] 
		raise: LcsSlotValidationError 
		description: 'String is too short'.
	self assert: (slot validate: '' context: nil oldValue: nil ) description: 'Null value should be allowed'.
	^ slot
]

{ #category : 'examples' }
LcsStringSlotExamples >> lastNameSlotAllowingNull [
	<gtExample>
	| slot |
	slot := self lastNameStringSlot.
	slot beAllowNull.
	self assert: (slot slotTypeRules collection size = 2). 
	self assert: (slot slotTypeRules first class == LcsAllowNullSlotTypeRule).

	self assert: (slot slotTypeRules validate: '' context: nil oldValue: nil).
	self assert: (slot slotTypeRules validate: 'ab' context: nil oldValue: nil).
	self should: [ slot slotTypeRules validate: 123 context: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	
	self assert: (slot validationRules validate: '' context: nil oldValue: nil).
	self assert: (slot validationRules validate: 'ab' context: nil oldValue: nil).
	self 
		shouldnt: [ slot validationRules validate: 123 context: nil oldValue: nil ] 
		raise: LcsInvalidSlotTypeError 
		description: 'There are no rules, so it passes'.
	
	self assert: (slot validate: '' context: nil oldValue: nil).
	self assert: (slot validate: 'ab' context: nil oldValue: nil).
	self should: [ slot validate: 123 context: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.	^ slot
]

{ #category : 'examples' }
LcsStringSlotExamples >> lastNameStringSlot [
	<gtExample>
	| slot |
	slot := self newSlot
			slotName: 'lastName';
			yourself.
	self assert: slot slotName equals: 'lastName'.
	^ slot
]

{ #category : 'examples' }
LcsStringSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsStringSlot new.
	self assert: slot slotTypes size = 1.
	self assert: (slot slotTypes includes: String).
	self assert: (slot validationRules hasNoElements).
	self assert: slot initialValue = ''.
	self assert: slot allowNil == false.
	self assert: slot allowNull == false.
	self assert: (slot isNullObject: '').
	
	self assert: (slot slotTypeRules validate: '' context: nil oldValue: nil).
	self assert: (slot slotTypeRules validate: 'ab' context: nil oldValue: nil).
	self should: [ slot slotTypeRules validate: 123 context: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	
	self assert: (slot validationRules validate: '' context: nil oldValue: nil).
	self assert: (slot validationRules validate: 'ab' context: nil oldValue: nil).
	self 
		shouldnt: [ slot validationRules validate: 123 context: nil oldValue: nil ] 
		raise: LcsInvalidSlotTypeError 
		description: 'There are no rules, so it passes'.
	
	self assert: (slot validate: '' context: nil oldValue: nil).
	self assert: (slot validate: 'ab' context: nil oldValue: nil).
	self should: [ slot validate: 123 context: nil oldValue: nil ] raise: LcsInvalidSlotTypeError.
	^ slot
]
