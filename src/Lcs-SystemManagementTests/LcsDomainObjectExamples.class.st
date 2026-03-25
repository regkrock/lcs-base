Class {
	#name : 'LcsDomainObjectExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LcsDomainObjectExamples >> addFooSlot [
	(LxxOrganization hasInstVarNamed: 'foo') ifFalse: [
		LxxOrganization addInstVarNamed: 'foo' ].
	^ LxxOrganization
]

{ #category : 'examples' }
LcsDomainObjectExamples >> createInstanceWhenSlotModelNotInitializedError [
	<gtExample>
	<noTest>
	self ensureNoCurrentSystem.
	self assert: LcsDomainObject slotModel isNil.
	^ LcsDomainObject new
]

{ #category : 'examples' }
LcsDomainObjectExamples >> parentSlotWhenSlotModelNotInitializedError [
	<gtExample>
	<noTest>
	self ensureNoCurrentSystem.
	self assert: LcsDomainObject slotModel isNil.
	self should: [ LcsDomainObject parentSlot ] raise: LcsSlotModelNotInitializedError. 
	^ LcsDomainObject parentSlot
]

{ #category : 'private' }
LcsDomainObjectExamples >> removeFooSlot [
	(LxxOrganization hasInstVarNamed: 'foo')
		ifTrue: [ LxxOrganization removeInstVarNamed: 'foo' ].
	^ LxxOrganization
]

{ #category : 'examples' }
LcsDomainObjectExamples >> slotDefinitionAndInstanceVariableMismatchError [
	<gtExample>
	<noTest>
	
	"Manually running this will return the error. 
	NOTE: The ensure wo;; remove the slot"

	self ensureCurrentSystemIsPrototypeSystem.
	[ self addFooSlot.	
	  self 
		should: [ LxxOrganization verifyNoSlotDefinitionInstanceVariableMismatch ] 
		raise: LcsSlotDefinitionAndInstanceVariableMismatchError.
	  LxxOrganization verifyNoSlotDefinitionInstanceVariableMismatch ]
		ensure: [ self removeFooSlot ]
]

{ #category : 'examples' }
LcsDomainObjectExamples >> superclassHasSlotModelNotInitializedError [
	<gtExample>
	<noTest>
	self ensureNoCurrentSystem.
	self assert: LcsDomainObject slotModel isNil.
	self should: [ LcsDomainObject superClassSlotModel ] raise: LcsSlotModelNotInitializedError. 
	^ LcsDomainObject superClassSlotModel
]
