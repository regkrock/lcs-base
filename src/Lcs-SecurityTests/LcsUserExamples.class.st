Class {
	#name : 'LcsUserExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SecurityTests-Examples',
	#package : 'Lcs-SecurityTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUserExamples >> auditedNewUser [
	<gtExample>
	<after: #clearUnitOfWork>
	| user auditor |
	user := self newUserInBasicSystem.
	self assert: (user verifyPassword: '').
	self assert: user userId equals: ''.
	self assert: user person isNil.
	auditor := LcsConditionsValidator newOn: self.
	self 
		assertAuditOf: user 
		slot: 'userId' 
		hasError: 'Null is not allowed'.
	self 
		assertAuditOf: user 
		slot: 'password' 
		hasError: 'Password must be least 8 characters long and include at least one number, one special character (+-/\*~<>=@,%|&?!·÷±×) and one uppercase character'.
	self 
		assertAuditOf: user 
		slot: 'person' 
		hasError: 'Nil is not allowed'.
	auditor := user auditSlots.
	self assert: auditor  errorDescriptions notEmpty.
	self assert: auditor errorDescriptions size equals: 1.
	^ user
]

{ #category : 'validation' }
LcsUserExamples >> newUser [
	| user |
	user := LcsUser new.
	self
		assert: (user slotDefinitionNamed: 'password') class
		equals: LcsPasswordSlot.
	self assert: (user slotDefinitionNamed: 'userId') class equals: LcsUserIdSlot.
	self
		assert: (user slotDefinitionNamed: 'fullName') errorClass
		equals: MessageNotUnderstood.
	self
		assert: (user slotDefinitionNamed: 'fullName') errorReturnObject
		equals: ''.
	self assert: user userId isEmpty.
	self assert: (user verifyPassword: '').
	self assert: user securityRole notNil.
	self assert: user securityRole role equals: 'guest'.
	^ user
]

{ #category : 'properties' }
LcsUserExamples >> newUserInBasicSystem [
	<gtExample>
	<after: #clearUnitOfWork>
	| user |
	self ensureCurrentSystemIsBasicSystem.
	self assert: self currentSystem unitOfWork hasNoChanges.
	self assert: LcsUnknownPerson hasSlotModel not.
	user := self newUser.
	self assert: (user verifyPassword: '').
	self assert: user person isNil.
	self assert: user fullName equals: ''.
	self shouldnt: [ user fullName ] raise: MessageNotUnderstood.
	^ user
]

{ #category : 'validation' }
LcsUserExamples >> newUserInDemoSystem [
	<gtExample>
	<after: #clearUnitOfWork>
	| user |
	self ensureCurrentSystemIsDemoSystem.
	self assert: LcsUnknownPerson hasSlotModel.
	user := self newUser.
	self assert: user person class equals: LcsUnknownPerson.
	self assert: user fullName equals: 'Unknown Person'.
	^ user
]

{ #category : 'properties' }
LcsUserExamples >> userInBasicSystemWithNoExceptionOverrideForUserFullName [
	<gtExample>
	| user |
	user := self newUserInBasicSystem.
	(user slotDefinitionNamed: 'fullName') errorClass: LcsDummyError.
	self assert: (user slotDefinitionNamed: 'fullName') errorClass equals: LcsDummyError.
	self should: [ user fullName ] raise: MessageNotUnderstood description: 'Error is not handled'.
	(user slotDefinitionNamed: 'fullName') errorClass: MessageNotUnderstood.
	self assert: (user slotDefinitionNamed: 'fullName') errorClass equals: MessageNotUnderstood.
	^ user
]

{ #category : 'examples' }
LcsUserExamples >> userWithAuditedPassword [
	<gtExample>
	<after: #clearUnitOfWork>
	| user auditor |
	user := self newUserInBasicSystem.
	auditor := LcsConditionsValidator newOn: self.
	self 
		assertAuditOf: user 
		slot: 'password' 
		hasError: 'Password must be least 8 characters long and include at least one number, one special character (+-/\*~<>=@,%|&?!·÷±×) and one uppercase character'.
	^ user
]

{ #category : 'examples' }
LcsUserExamples >> userWithValidPassword [
	<gtExample>
	<after: #clearUnitOfWork>
	| user pwd|
	user := self newUserInBasicSystem.

	pwd := 'Abc'.
	self  
		should: [ user password: pwd ] 
		raise: LcsSlotValidationError
		description: 'Password is too short'.

	pwd := 'Abc@1'.
	self
		should: [ user password: pwd ] 
		raise: LcsSlotValidationError
		description: 'Password is too short'.

	pwd := 'abcdef12+'.
	self
		should: [ user password: pwd ] 
		raise: LcsSlotValidationError
		description: 'Long enough but no special character'.

	pwd := 'abcdef12@'.
	self
		should: [ user password: pwd ] 
		raise: LcsSlotValidationError
		description: 'Password has no capital letter'.

	pwd := 'Abcdef123'.
	self 
		should: [ user password: pwd ] 
		raise: LcsSlotValidationError
		description: 'Password has no special character'.
	pwd := 'Abcdef123'.
	self  should: [ user password: pwd ] raise: LcsSlotValidationError.
	(LcsPasswordHasher verifyPassword: '' againstStoredHash: user password).
	
	pwd := 'Abcdef12+'.
	user password: pwd.
	self assert: (LcsPasswordHasher verifyPassword: pwd againstStoredHash: user password).
	"self assertAuditHasNoErrorOf: user slot: 'password'. "
	^ user
]
