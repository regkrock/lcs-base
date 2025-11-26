Class {
	#name : 'LcsAuditorTest',
	#superclass : 'LcsPrototypeSystemRunningTestCase',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
LcsAuditorTest >> testAuditingNewPerson [
	| anAuditor |
	self subject: LxxPerson basicNew.

	anAuditor := self subject auditSlots.
	self assert: anAuditor hasErrors.
	self assert: (anAuditor errorDescriptions includes: '''parent'' slot("LcsGlobalCollectionReferenceSlot") in LxxPerson is not in its global collection').
	
	self subject initialize.
	self currentSystem applyChanges.
	
	anAuditor := self subject auditSlots.
	self assert: anAuditor hasNoErrors.
]

{ #category : 'as yet unclassified' }
LcsAuditorTest >> testAuditingWithParentSlotWithAnInvalidValue [
	| anAuditor |
	self subject: LxxPerson new.
	self currentSystem applyChanges.
	self subject instVarNamed: 'parent' put: nil.
	self assert: self subject parent equals: nil.
	anAuditor := self subject auditSlots.
	self assert: anAuditor hasErrors.
	self assert: anAuditor errorDescriptions first equals: '''parent''  slot("LcsGlobalCollectionReferenceSlot") in LxxPerson contains invalid: nil'
]

{ #category : 'as yet unclassified' }
LcsAuditorTest >> testAuditingWithSmalltalkSlotWithAnInvalidValue [
	| anAuditor |
	self subject: LxxPerson new.
	self commitTransaction.
	self subject instVarNamed: 'balance' put: 'r'.
	self assert: self subject balance equals: 'r'.
	anAuditor := self subject auditSlots.
	self assert: anAuditor hasErrors.
	self assert: anAuditor errorDescriptions first equals: '''balance''  slot("LcsScaledDecimalSlot") in LxxPerson contains invalid: ''r'''
]
