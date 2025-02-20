Class {
	#name : #LcsAllSubmodulesVisitorTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#instVars : [
		'refactoring',
		'originalSource'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testNestedSubmodules [
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	self assert: subject allSubmodules notEmpty.
	self assert: subject allSubmodules size = 3.
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodules [
	subject := LcsAllSubmodulesVisitor newOn: LxxModuleWithOwningModuleBeingItself.
	self should: [ subject allSubmodules ] raise: LcsError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testSubmodulesWhereNoSubmoduleExists [
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototypePersonsModule.
	self assert: subject allSubmodules isEmpty
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testSubmodulesWhereOneSubmoduleExists [
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototype2Module.
	self assert: subject allSubmodules size equals: 1
]
