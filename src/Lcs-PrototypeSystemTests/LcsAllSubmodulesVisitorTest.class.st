Class {
	#name : #LcsAllSubmodulesVisitorTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#instVars : [
		'refactoring'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #setUp }
LcsAllSubmodulesVisitorTest >> tearDown [
	refactoring notNil ifTrue: [
		refactoring asUndoOperation execute
		"(RBRemoveMethodChange remove: #owningModules from: LxxPrototype2Submodule class) execute"].
	super tearDown
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testNestedSubmodules [
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	self assert: subject allSubmodules notEmpty.
	self assert: subject allSubmodules size = 3.
]

{ #category : #tests }
LcsAllSubmodulesVisitorTest >> testRecursiveSubmodules [
	(refactoring := RBAddMethodChange
		compile: 'owningModules
	<owningModule: ''LxxPrototype2Module''>
	<owningModule: ''LxxPrototypeSystem''>'
		in: LxxPrototype2Submodule class
		classified: #temp).
	refactoring execute.
	
	subject := LcsAllSubmodulesVisitor newOn: LxxPrototypeSystem.
	self assert: subject allSubmodules size equals: 1
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
