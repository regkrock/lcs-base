Class {
	#name : 'LcsAllSubmodulesVisitorExamples',
	#superclass : 'LcsExamples',
	#instVars : [
		'refactoring',
		'originalSource'
	],
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> allSubModulesInLxxPrototypeSystem [
	<gtExample>
	| modules visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	modules := visitor allSubmoduleClasses.
	self assert: modules notEmpty.
	self assert: modules size equals: 4.
	^ visitor
]

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> moduleHierarchyError [
	<gtExample>
	<noTest>
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModule0.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError.
	
	visitor := LcsAllSubmodulesVisitor newOn: LxxTestModule1.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError.
	^ visitor allSubmoduleClasses
]

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> visitorOnModuleWitheNoSubmodules [
	<gtExample>
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPersonsModule.
	self assert: visitor allSubmoduleClasses isEmpty.
	^ visitor
]

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> visitorWhereModuleIsOwnedByItself [
	<gtExample>
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModuleWithOwningModuleBeingItself.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError.
	^ visitor
]

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> visitorWithCyclicalStructure [
	<gtExample>
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxModule0.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError.
	
	visitor := LcsAllSubmodulesVisitor newOn: LxxTestModule1.
	self should: [ visitor allSubmoduleClasses ] raise: LcsModuleHierarchyError.
	^ visitor
]

{ #category : 'examples' }
LcsAllSubmodulesVisitorExamples >> visitorWithSubmodulesWhereOneSubmoduleExists [
	<gtExample>
	| visitor |
	visitor := LcsAllSubmodulesVisitor newOn: LxxPrototype2Module.
	self assert: visitor allSubmoduleClasses size equals: 1.
	^ visitor
]
