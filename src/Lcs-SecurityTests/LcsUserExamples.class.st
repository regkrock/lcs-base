Class {
	#name : 'LcsUserExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SecurityTests-Examples',
	#package : 'Lcs-SecurityTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUserExamples >> newUser [
	<gtExample>
	<after: #clearUnitOfWork>
	| user auditor |
	self ensureCurrentSystemIsBasicSystem.
	self assert: self currentSystem unitOfWork hasNoChanges.
	user := LcsUser new.
	auditor := LcsConditionsValidator newOn: self.
	self assert: user userid isEmpty.
	self 
		assertAuditOf: user 
		slot: 'userid' 
		equals: 'Attempt to initialize slot with null when in a state other than initialization'.
	self assert: user password isEmpty.
	self 
		assertAuditOf: user 
		slot: 'password' 
		equals: 'Password is required'.
	self assert: user person isNil.
	self 
		assertAuditOf: user 
		slot: 'person' 
		equals: 'Attempt to initialize slot with nil when in a state other than initialization'.
	self assert: user securityRole notNil.
	self assert: user securityRole role equals: 'guest'.
	auditor := user auditSlots.
	self assert: auditor  errorDescriptions notEmpty.
	self assert: auditor errorDescriptions size equals: 3.
	^ user
]
