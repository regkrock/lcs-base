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
		equals: 'Attempt to initialize slot with null when in a state other than initialization'.
	self 
		assertAuditOf: user 
		slot: 'password' 
		equals: 'Password is required'.
	self 
		assertAuditOf: user 
		slot: 'person' 
		equals: 'Attempt to initialize slot with nil when in a state other than initialization'.
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
