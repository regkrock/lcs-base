Class {
	#name : #LcsSlotGetterAndSetterBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #accessing }
LcsSlotGetterAndSetterBuilderTest >> codeBuilder [
	^ codeBuilder
]

{ #category : #accessing }
LcsSlotGetterAndSetterBuilderTest >> codeBuilder: aCodeBuilder [
	codeBuilder := aCodeBuilder
]

{ #category : #running }
LcsSlotGetterAndSetterBuilderTest >> tearDown [
	self codeBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilder ifNotNil: [ :builder | builder verifyUninstall]
]

{ #category : #tests }
LcsSlotGetterAndSetterBuilderTest >> testInstallingGetterAndSetter [
	self codeBuilder: (
		LcsSlotGetterAndSetterBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self codeBuilder installCode.
	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol)
]
