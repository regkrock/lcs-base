Class {
	#name : 'LcsSecurityModuleExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SecurityTests-Examples',
	#package : 'Lcs-SecurityTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LcsSecurityModuleExamples >> newModule [
	<gtExample>
	| module |
	self ensureCurrentSystemIsBasicSystem.
	self clearUnitOfWork.

	module := LcsSecurityModule new.
	self assert: (module currentUser isKindOf: LcsSuperUser).
	self assert: (module configuration isKindOf: LcsSecurityModuleConfiguration).
	self assert: module modules hasNoElements.
	self assert: module securityRoles pendingAdds size = 6.
	"self currentSystem applyChanges."
	^ module
]
