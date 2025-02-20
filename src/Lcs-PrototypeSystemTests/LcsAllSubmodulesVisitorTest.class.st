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
	| modules |
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	modules := subject allSubmodules.
	self assert: modules notEmpty.
	self assert: modules size = 3.
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule0OwnsModule1AndModule2AreOwnedyEachOther [
	subject := LcsAllSubmodulesVisitor newOn: LxxModule0.
	self should: [ subject allSubmodules ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule1AndModule2AndModule3AreInACircularOwnership [
	subject := LcsAllSubmodulesVisitor newOn: LxxTestModule1.
	self should: [ subject allSubmodules ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule1AndModule2AreOwnedyEachOther [
	subject := LcsAllSubmodulesVisitor newOn: LxxModule1.
	self should: [ subject allSubmodules ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModuleIsOwnedByItself [
	subject := LcsAllSubmodulesVisitor newOn: LxxModuleWithOwningModuleBeingItself.
	self should: [ subject allSubmodules ] raise: LcsModuleHierarchyError
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
