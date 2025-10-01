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
	| modules visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	modules := visitor allSubmoduleClasses.
	self assert: modules notEmpty.
	self assert: modules size equals: 4.
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule0OwnsModule1AndModule2AreOwnedyEachOther [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModule0.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule1AndModule2AndModule3AreInACircularOwnership [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxTestModule1.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModule1AndModule2AreOwnedyEachOther [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModule1.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodulesWhereModuleIsOwnedByItself [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModuleWithOwningModuleBeingItself.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testSubmodulesWhereNoSubmoduleExists [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPersonsModule.
	self assert: visitor allSubmoduleClasses isEmpty
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testSubmodulesWhereOneSubmoduleExists [
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPrototype2Module.
	self assert: visitor allSubmoduleClasses size equals: 1
]
