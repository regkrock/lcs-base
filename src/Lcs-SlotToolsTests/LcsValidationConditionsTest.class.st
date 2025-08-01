Class {
	#name : #LcsValidationConditionsTest,
	#superclass : #LcsTestWithNoApplicationEnvironmentTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsValidationConditionsTest >> testAddingValidationCondition [
	| validationDescription validationCondition conditionBlock |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :value | Date today < value ].
	self subject: LcsValidationConditions new.
	self subject addValidationCondition: conditionBlock description: validationDescription.
	validationCondition := self subject validationConditionWithDescription: validationDescription.
	self assert: validationCondition validationDescription equals: validationDescription.
	self assert: validationCondition conditionBlock equals: conditionBlock.
	self assert:self subject collection size equals: 1
]

{ #category : #tests }
LcsValidationConditionsTest >> testCreation [
	self subject: LcsValidationConditions new.
	self assert: self subject collection isEmpty.
	self assert: self subject parent isNil.
	self assert: (self subject collection isKindOf: OrderedCollection)
]

{ #category : #tests }
LcsValidationConditionsTest >> testRemovingValidationCondition [
	| validationDescription validationCondition conditionBlock |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :value | Date today < value ].
	self subject: LcsValidationConditions new.
	self subject addValidationCondition: conditionBlock description: validationDescription.
	self assert: self subject collection size equals: 1.
	validationCondition := self subject collection at: 1.
	
	self subject removeValidationCondition: validationCondition.
	self assert: self subject collection isEmpty.

	self subject addValidationCondition: conditionBlock description: validationDescription.
	validationCondition := self subject detect: [ :each | each validationDescription = validationDescription ].
	self assert: self subject collection size equals: 1.
	self subject removeValidationCondition: validationCondition.
	self assert: self subject collection isEmpty.
]

{ #category : #tests }
LcsValidationConditionsTest >> testValidation [
	| validationDescription conditionBlock |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :value | Date today < value ].
	self subject: LcsValidationConditions new.
	self subject addValidationCondition: conditionBlock description: validationDescription.

	self subject validate: Date today
]

{ #category : #tests }
LcsValidationConditionsTest >> testValidationViaSlot [
	| validationDescription conditionBlock |
	validationDescription := 'Date must be today or beyond'.
	conditionBlock := [ :value | value < Date today ].
	self subject: LcsStringSlot new.
	self assert: self subject validationConditions collection isEmpty.
	self subject addValidationCondition: conditionBlock description: validationDescription.

	self assert: (self subject validate: Date today) hasNoErrors.
	
	self assert: (self subject validate: (Date today subtractDays: 1)) hasErrors
]
