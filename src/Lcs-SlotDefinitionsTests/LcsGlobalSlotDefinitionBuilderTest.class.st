Class {
	#name : #LcsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilderTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #running }
LcsGlobalSlotDefinitionBuilderTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsGlobalSlotDefinitionBuilderTest >> testInstallingGlobalCollectionSlot [
	self codeJobBuilder: LcsCodeBuilderJob new.
	self codeJobBuilder addJobStep: (
		LcsGlobalSlotDefinitionBuilder new
			slotClassName: LxxPersons name;
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			targetModuleClass: self currentSystem class name;
			collectionElementTypes: { LxxPerson name };
			yourself).
	self codeJobBuilder execute.
	self assert: (self currentSystem class hasSlotDefinitionNamed: 'foos')
]
