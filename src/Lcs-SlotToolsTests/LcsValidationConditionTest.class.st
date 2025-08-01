Class {
	#name : #LcsValidationConditionTest,
	#superclass : #LcsTestWithNoApplicationEnvironmentTest,
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #scripter }
LcsValidationConditionTest >> subjectScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LcsValidationCondition new ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: true.

	^ aScripter
]

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
LcsValidationConditionTest >> testMagritteForm [
	<gtExample>
	<return: #BlScripter>
	| aScripter aValidationDescriptionId aConditionBlockId anAcceptId aCancelId |
	
	aScripter := self subjectScripter.

	aValidationDescriptionId := GtMagritteFieldElementId new description: aScripter model validationDescriptionDescription.
	aConditionBlockId := GtMagritteFieldElementId new description: aScripter model conditionBlockDescription.
	anAcceptId := GtMagritteActionElementId new description: aScripter model magritteAcceptAction.
	aCancelId := GtMagritteActionElementId new description: aScripter model magritteCancelAction.

	aScripter
		substeps: 'Change validation description value'
		do: [ :aStep | 

			aStep requestFocus
				// aValidationDescriptionId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: 'invalid condition description';
						// aValidationDescriptionId ].

			"aStep
				assertStep: [ :s | 
					s
						label: 'Assert model validation description value';
						value: [ :aModel | aModel validationDescription ] equals: [ 'invalid condition description' ];
						onModel ]."
						
			self
				assert: aStep
				model: aScripter model
				acceptEnabled: false
				cancelEnabled: true ].

	aScripter
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
				model: aScripter model
				acceptEnabled: true
				cancelEnabled: true ].
				
	aScripter
		substeps: 'Accept changed values'
		do: [ :aStep | 
			aStep clickStep: [ :s | s // anAcceptId ].

			self
				assert: aStep
				model: aScripter model
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

	^ aScripter
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
LcsValidationConditionTest >> testSubjectScripter [
	self subjectScripter
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
