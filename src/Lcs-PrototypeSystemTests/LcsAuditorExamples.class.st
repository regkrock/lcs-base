Class {
	#name : 'LcsAuditorExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LcsAuditorExamples >> auditNewPerson [
	<gtExample>
	<after: #clearUnitOfWork>
	| auditor person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson basicNew.
	auditor := person auditSlots.
	self assert: auditor hasErrors.
	self assert: (auditor errorDescriptions includes: '''parent'' slot("LcsGlobalCollectionReferenceSlot") in LxxPerson is not in its global collection').
	
	person initialize.
	auditor := person auditSlots.
	self assert: auditor hasNoErrors.
	^ auditor
]

{ #category : 'as yet unclassified' }
LcsAuditorExamples >> auditOfPersonWithInvalidValeInBalanceSlot [
	<gtExample>
	| auditor person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	self commitTransaction.
	person instVarNamed: 'balance' put: 'r'.
	self assert: person balance equals: 'r'.
	auditor := person auditSlots.
	self assert: auditor hasErrors.
	self 
		assert: auditor errorDescriptions first 
		equals: 'Attempt to update balance  slot("LcsScaledDecimalSlot") in "LxxPerson" with: ''r'''.
	^ auditor
]

{ #category : 'as yet unclassified' }
LcsAuditorExamples >> auditOfPersonWithParentSlotWithAnInvalidValue [
	<gtExample>
	| auditor person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person instVarNamed: 'parent' put: nil.
	self assert: person parent equals: nil.
	auditor := person auditSlots.
	self assert: auditor hasErrors.
	self 
		assert: auditor errorDescriptions first 
		equals: 'Attempt to update parent  slot("LcsGlobalCollectionReferenceSlot") in "LxxPerson" with: nil'.
	^ auditor
]
