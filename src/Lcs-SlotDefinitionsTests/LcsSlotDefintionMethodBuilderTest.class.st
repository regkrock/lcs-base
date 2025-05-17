Class {
	#name : #LcsSlotDefintionMethodBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsSlotDefintionMethodBuilderTest >> codeBuilder [
	^ codeBuilder
]

{ #category : #accessing }
LcsSlotDefintionMethodBuilderTest >> codeBuilder: anObject [
	codeBuilder := anObject
]

{ #category : #running }
LcsSlotDefintionMethodBuilderTest >> tearDown [
	self codeBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSlotDefintionMethodBuilderTest >> testInstallingSlotDefinitionMethod [
	self codeBuilder: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foos';
			slotDefinitionClass: LcsStringSlot;
			targetClassName: self currentSystem class name;
			yourself).
	self codeBuilder installCode.
	self assert: (self currentSystem class respondsTo: ('foos' , 'SlotDefinition') asSymbol)
]
