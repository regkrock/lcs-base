Class {
	#name : #LcsSlotInstanceVariableBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsSlotInstanceVariableBuilderTest >> codeBuilder [
	^ codeBuilder
]

{ #category : #accessing }
LcsSlotInstanceVariableBuilderTest >> codeBuilder: anObject [
	codeBuilder := anObject
]

{ #category : #running }
LcsSlotInstanceVariableBuilderTest >> tearDown [
	self codeBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSlotInstanceVariableBuilderTest >> testInstallingSlot [
	self codeBuilder: (
		LcsSlotInstanceVariableBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self codeBuilder installCode.
	self assert: (self currentSystem class instVarNames includes: 'foos')
]
