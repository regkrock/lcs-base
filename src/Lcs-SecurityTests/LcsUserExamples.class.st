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
	user := self newUser.
	auditor := LcsConditionsValidator newOn: self.
	self 
		assertAuditOf: user 
		slot: 'userId' 
		hasError: 'Attempt to initialize slot with null when in a state other than initialization'.
	self 
		assertAuditOf: user 
		slot: 'password' 
		hasError: 'Password is required'.
	self 
		assertAuditOf: user 
		slot: 'person' 
		hasError: 'Attempt to initialize slot with nil when in a state other than initialization'.
	auditor := user auditSlots.
	self assert: auditor  errorDescriptions notEmpty.
	self assert: auditor errorDescriptions size equals: 3.
	^ user
]

{ #category : 'examples' }
LcsUserExamples >> newUser [
	<gtExample>
	<after: #clearUnitOfWork>
	| user |
	self ensureCurrentSystemIsBasicSystem.
	self assert: self currentSystem unitOfWork hasNoChanges.
	user := LcsUser new.
	self assert: (user slotDefinitionNamed: 'password') class equals: LcsPasswordSlot.
	self assert: (user slotDefinitionNamed: 'userId') class equals: LcsUserIdSlot.
	self assert: user userId isEmpty.
	self assert: user password isEmpty.
	self assert: user person isNil.
	self assert: user securityRole notNil.
	self assert: user securityRole role equals: 'guest'.
	^ user
]

{ #category : 'examples' }
LcsUserExamples >> userWithValidPassword [
	<gtExample>
	<after: #clearUnitOfWork>
	| user pwd|
	user := self newUser.

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
	self assert: user password equals: ''.

	pwd := 'Abcdef12+'.
	user password: pwd.
	self assert: user password equals: pwd.
	self assertAuditHasNoErrorOf: user slot: 'password'.
	^ user
]
