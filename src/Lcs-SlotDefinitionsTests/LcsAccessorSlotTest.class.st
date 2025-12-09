Class {
	#name : 'LcsAccessorSlotTest',
	#superclass : 'LcsTestCase',
	#category : 'Lcs-SlotDefinitionsTests-Tests',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsAccessorSlotTest >> testAddingPostUpdateActions [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addPostUpdateAction: (
		LcsUpdateSiblingWithCollectionDefault new 
			description: 'When country changes, update the default province';
			siblingSlotName: 'province';
			sourceCollectionSlotName: 'subdivisions';
			yourself).
	self assert: self subject postUpdateActions collection size equals: 1.
	self assert: self subject postUpdateActions collection any parent identicalTo: self subject postUpdateActions.
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAddingPostUpdateActionsCodeGeneration [
	| aStream |
	aStream := LcsMethodStream new.
	self subject: LcsAccessorSlotExamples new accessorSlotWithPostUpdateActions.
	aStream addKeyword: 'addPostUpdateAction' withRenderedAction: self subject postUpdateActions first.
	self assert: aStream contents equals: 'addPostUpdateAction: (
	LcsUpdateSiblingWithCollectionDefault new
		description: ''When country changes, update the default province'';
		siblingSlotName: ''province'';
		sourceCollectionSlotName: ''subdivisions'';
		yourself);'
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAddingPostUpdateActionsCodeGenerationWithDifferentActionBlock [
	| aStream |
	aStream := LcsMethodStream new.
	self subject: LcsAccessorSlotExamples new accessorSlotWithBasicPostUpdateActions.
	self subject postUpdateActions first actionBlock: [ :newValue :parentDomainObject :oldValue | ]. 
	aStream addKeyword: 'addPostUpdateAction' withRenderedAction: self subject postUpdateActions first.
	self assert: aStream contents equals: 'addPostUpdateAction: (
	LcsUpdateSiblingWithCollectionDefault new
		actionBlock: [ :newValue :parentDomainObject :oldValue | ];
		yourself);'
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAddingPostUpdateActionsCodeGenerationWithNoChanges [
	| aStream |
	aStream := LcsMethodStream new.
	self subject: LcsAccessorSlotExamples new accessorSlotWithBasicPostUpdateActions.
	aStream addKeyword: 'addPostUpdateAction' withRenderedAction: self subject postUpdateActions first.
	self assert: aStream contents equals: 'addPostUpdateAction: (
	LcsUpdateSiblingWithCollectionDefault new);'
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAddingValidationConditionAndDescription [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAllowNil [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self assert: self subject allowNil == false.
	self deny: self subject isNilAllowed.
	self subject beAllowNil.
	self assert: self subject allowNil == true.
	self assert: self subject isNilAllowed
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testAllowNilDescription [
	| margritteDescription |
	self subject: LcsAccessorSlotExamples new accessorSlot.
	margritteDescription := self subject allowNilDescription.
	self assert: (margritteDescription read: self subject) = false.
	margritteDescription write: true to: self subject.
	self assert: (margritteDescription read: self subject) = true.
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testCreation [

	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date)
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testInitalValueSetToNil [
	self subject:  LcsAccessorSlotExamples new accessorSlot.

	self subject initialValue: nil.
	self assert: self subject initialValueBlock printString equals: '[ :parentDomainObject :slot | nil ]'.
	self assert: (self subject initialValueBlock cull: self cull: self) isNil
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testPrevalidationTransformBlockDescription [
	| description |
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self assert: self subject prevalidationTransformBlock asString equals: '[ :value :slot | value ]'.
	
	description := self subject prevalidationTransformBlockDescription.
	self assert: (description read: self subject) equals: 'value'.
			
	description write: '0' to: self subject.
	self assert: (description read: self subject) equals: '0'.

	self assert: self subject prevalidationTransformBlock asString equals: '[ :value :slot | 0 ]'
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testRemovingPostUpdateAction [
	| updateAction |
	self subject: LcsAccessorSlotExamples new accessorSlotWithDummyPostUpdateAction.
	self assert: self subject postUpdateActions collectionSize equals: 1.
	updateAction := self subject postUpdateActions collection any.
	self subject removeAction: updateAction.
	self assert: self subject postUpdateActions collectionSize equals: 0.

]

{ #category : 'tests' }
LcsAccessorSlotTest >> testRemovingValidationCondition [
	| validationCondition |
	self subject: LcsAccessorSlotExamples new accessorSlotWithDummyValidationAction.
	self assert: self subject validationConditions collection size equals: 1.
	validationCondition := self subject validationConditions any.
	self subject removeValidationCondition: validationCondition.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testRemovingValidationConditionViaDescription [
	| validationCondition |
	self subject: LcsAccessorSlotExamples new accessorSlotWithDummyValidationAction.
	validationCondition := self subject validationConditions any.
	self subject removeValidationConditionWithDescription: 'Test'.
	self assert: self subject validationConditions hasNoElements
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testRequried [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self assert: self subject isRequired not.
	self subject beRequired.
	self assert: self subject isRequired.
	self subject beOptional.
	self assert: self subject isRequired not
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testSlotTypes [

	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date).
	
	self subject slotTypes remove: Date.
	self assert: self subject slotTypes isEmpty.
	
	self subject addSlotType: Date.
	self assert: self subject slotTypes size = 1.
	
	self subject removeSlotType: Date.
	self assert: self subject slotTypes isEmpty.
	
	self should: [ self subject addSlotType: 'Date' ] raise: AssertionFailure.

]

{ #category : 'tests' }
LcsAccessorSlotTest >> testSlotTypesDescription [
	| description |
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addSlotType: String.
	description := self subject slotTypesDescription.
	self assert: (description read: self subject) equals: (OrderedCollection with: #String).
	description write: (OrderedCollection with: #String with: #Integer) to: self subject.
	self assert: self subject slotTypes equals: (OrderedCollection with: String with: Integer).
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testUpdatingInitialValueBlockViaMagritteDescription [
	| description |
	self subject: LcsAccessorSlotExamples new accessorSlot.
	
	description := self subject initialValueBlockDescription.
	self assert: (description read: self subject) equals: '(slot slotTypes any new)
			parent: parentDomainObject;
			yourself'.
			
	description write: '0' to: self subject.
	self assert: (description read: self subject) equals: '0'.

	self assert: self subject initialValueBlock asString equals: '[ :parentDomainObject :slot | 0 ]'
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testValidationConditions [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self assert: self subject validationConditions class == LcsValidationConditions.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testValidationWithNoValidationConditions [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self shouldnt: (self subject validate: 'abc') raise: LcsSlotValidationError
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testValidationWithOneFailingValidationConditions [
	| validator |
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addValidationCondition: [ :value |  
			value isInteger not ] description: 'Must be an Ingeter'.
	validator := self subject validate: 'abc'.
	self assert: validator hasErrors.
	self assert: (validator hasError: 'Must be an Ingeter')

]

{ #category : 'tests' }
LcsAccessorSlotTest >> testValidationWithOnePassingValidationConditions [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self subject addValidationCondition: [ :value |  
			value isInteger not ] description: 'Must be an Ingeter'.
	self shouldnt: [ self subject validate: 1 ] raise: LcsSlotValidationError
]

{ #category : 'tests' }
LcsAccessorSlotTest >> testVariableUpdatePolicy [
	self subject: LcsAccessorSlotExamples new accessorSlot.
	self assert: self subject variableUpdatePolicyClass equals: LcsUnitOfWorkVariableUpdatePolicy.
	self subject makeDirectUpdateOfVariable.
	self assert: self subject variableUpdatePolicyClass equals: LcsDirectVariableUpdatePolicy.
	self assert: (self subject variableUpdatePolicy isKindOf: LcsDirectVariableUpdatePolicy).
]
