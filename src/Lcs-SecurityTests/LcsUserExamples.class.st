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
	| user auditer|
	self ensureCurrentSystemIsBasicSystem.
	self assert: self currentSystem unitOfWork hasNoChanges.
	user := LcsUser new.
	self assert: user userid isEmpty.
	self assert: user password isEmpty.
	self assert: user person isNil.
	self assert: user securityRole notNil.
	self assert: user securityRole role equals: 'guest'.
	auditer := user auditSlots.
	self assert: auditer  errorDescriptions notEmpty.
	^ auditer
]
