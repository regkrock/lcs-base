Class {
	#name : 'LcsValidationConditionExamples',
	#superclass : 'LcsExamples',
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsValidationConditionExamples >> birthDateValidationCondition [
	<gtExample>
	| condition validationDescription conditionBlock |
	validationDescription :=  'Age must be between 0 and 120 years'.
	"conditionBlock := [ :newDate | newDate year > (Date today year - 120) or: [ newDate > Date today ] ]."
	conditionBlock := [ :newDate | ((newDate year) > (Date today year - 120)) and: [ newDate <= Date today ] ].
	condition := self newValidationCondition
					validationDescription: validationDescription;
					conditionBlock: conditionBlock.

	self assert: (condition validate: Date today).
	self assert: (condition validate: (Date newDay: 31 month: 12 year: (Date today year - 119))).
	self should: [ condition validate: (Date newDay: 31 month: 12 year: (Date today year - 120)) ] raise: LcsSlotValidationError.
	self should: [ condition validate: (Date today addDays: 1) ] raise: LcsSlotValidationError.

	^ condition
]

{ #category : 'tests' }
LcsValidationConditionExamples >> conditionWithBlockThatComparesValueToFalse [
	<gtExample>
	| condition |
	condition := self newValidationCondition.
	condition conditionBlock: [ :value :parentDomainObject | value == false ].
	self should: [ condition validate: true ] raise: LcsSlotValidationError.
	self shouldnt: [ condition validate: false ] raise: LcsSlotValidationError.
	self should: [ condition validate: true context: 'aString' ] raise: LcsSlotValidationError.
	self shouldnt: [ condition validate: false context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ condition validate: true context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self shouldnt: [ condition validate: false context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	^ condition
]

{ #category : 'tests' }
LcsValidationConditionExamples >> conditionWithBlockThatReturnsFalse [
	<gtExample>
	| condition |
	condition := self newValidationCondition.
	condition conditionBlock: [ :value :parentDomainObject | false ].
	self should: [ condition validate: true ] raise: LcsSlotValidationError.
	self should: [ condition validate: false ] raise: LcsSlotValidationError.
	self should: [ condition validate: true context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ condition validate: false context: 'aString' ] raise: LcsSlotValidationError.
	self should: [ condition validate: false context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	self should: [ condition validate: true context: 'aString' oldValue: 'xxx' ] raise: LcsSlotValidationError.
	^ condition
]

{ #category : 'tests' }
LcsValidationConditionExamples >> conditionWithMessageNotUnderstoodError [
	<gtExample>
	| condition |
	condition := self newValidationCondition
					validationDescription: 'Value >= 10';
					conditionBlock: [ :value :parentDomainObject | value + 5 < 10 ].
	self 
		should: [ condition validate: true context: 'aString' ]  
		raise: LcsSlotValidationExecutionError.
	self 
		shouldnt: [ condition validate: 2 context: 'aString' ] 
		raise: LcsSlotValidationBaseError
]

{ #category : 'tests' }
LcsValidationConditionExamples >> dateValidationCondition [
	<gtExample>
	| condition validationDescription conditionBlock |
	validationDescription :=  'Date must be today or beyond'.
	conditionBlock := [ :newDate | newDate < Date today ].
	condition := self newValidationCondition
					validationDescription: validationDescription;
					conditionBlock: conditionBlock.
	self assert: condition conditionBlock == conditionBlock.
	self assert: condition validationDescription == validationDescription.
	self assert: condition parent isNil.

	self assert: (condition validate: (Date today subtractDays: 1)).
	self should: [ condition validate: 'xxxx' ] raise: LcsSlotValidationExecutionError.
	self should: [ condition validate: Date today ] raise: LcsSlotValidationError.

	^ condition
]

{ #category : 'tests' }
LcsValidationConditionExamples >> newValidationCondition [
	<gtExample>
	| condition |
	condition := LcsValidationCondition new.
	self assert: condition conditionBlock displayString equals: '[ :value | true ]'.
	self assert: condition validationDescription isNil.
	self assert: condition parent isNil.
	self assert: (condition validate: true) equals: true.
	self assert: (condition validate: 'xxxx') equals: true. 
	^ condition
]

{ #category : 'tests' }
LcsValidationConditionExamples >> testMagritteForm [
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

{ #category : 'scripter' }
LcsValidationConditionExamples >> validationConditionScripter [
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
