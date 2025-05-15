Class {
	#name : #LcsSlotDefinitionBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsSlotDefinitionBuilderTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsSlotDefinitionBuilderTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #running }
LcsSlotDefinitionBuilderTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSlotDefinitionBuilderTest >> testInstallingSlot [
	self codeJobBuilder: LcsCodeBuilderJob new.
	self codeJobBuilder addJobStep: (
		LcsSlotDefinitionBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			"targetModuleClass: self currentSystem class name;"
			addSlotType: LxxPerson name ;
			yourself).
	self codeJobBuilder execute.
	self assert: (self currentSystem class hasSlotDefinitionNamed: 'foos')
]
