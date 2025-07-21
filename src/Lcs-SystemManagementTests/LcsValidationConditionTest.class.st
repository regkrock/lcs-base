Class {
	#name : #LcsValidationConditionTest,
	#superclass : #LcsTestWithNoApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #tests }
LcsValidationConditionTest >> testCreatingOnValidationConditions [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self assert: self subject conditionBlock displayString equals: '[ :value | true ]'.
	self assert: self subject validationDescription isNil.
	self assert: self subject parent == validationConditions.
	self should: [ self subject validate: 'xxxx' ] raise: LcsSlotValidationError
]

{ #category : #tests }
LcsValidationConditionTest >> testCreation [
	self subject: LcsValidationCondition new.
	self assert: self subject conditionBlock displayString equals: '[ :value | true ]'.
	self assert: self subject validationDescription isNil.
	self assert: self subject parent isNil.
	self should: [ self subject validate: 'xxxx' ] raise: LcsSlotValidationError
]

{ #category : #tests }
LcsValidationConditionTest >> testErrorConditionWithValueAndRelatedObject [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self subject conditionBlock: [ :value :domainObject | value + 5 ].
	self should: [ self subject validate: true context: 'aString' ]  raise: LcsSlotValidationExecutionError
]

{ #category : #tests }
LcsValidationConditionTest >> testInvalidCondition [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self subject conditionBlock: [ :value | false ].
	self assert: self subject conditionBlock displayString equals: '[ :value | false ]'.
	self assert: (self subject validate: 'xxxx') equals: false.
]

{ #category : #tests }
LcsValidationConditionTest >> testInvalidConditionWithValueAndRelatedObject [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self subject conditionBlock: [ :value :domainObject | value == false ].
	self should: [ self subject validate: false context: 'aString' ]  raise: LcsSlotValidationError.
	self assert: (self subject validate: true context: 'aString') == false
]

{ #category : #tests }
LcsValidationConditionTest >> testNonBooleanCondition [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self subject conditionBlock: [ :value | nil ].
	self assert: self subject conditionBlock displayString equals: '[ :value | nil ]'.
	self should: [self subject validate: 'xxxx' ]  raise: LcsSlotValidationNonBooleanResultError
]

{ #category : #tests }
LcsValidationConditionTest >> testValidConditionWithValueAndRelatedObject [
	| validationConditions |
	validationConditions := LcsValidationConditions new.
	self subject: (LcsValidationCondition newOn: validationConditions).
	self subject conditionBlock: [ :value :domainObject | value == true ].
	self assert: (self subject validate: false context: 'aString') equals: false.
	self should: [ self subject validate: true context: 'aString' ] raise:  LcsSlotValidationError
]
