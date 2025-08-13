Class {
	#name : #LcsSlotGetterBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSlotGetterBuilderTest >> testInstallingGetter [
	self deny: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	self subject: (
		LcsSlotGetterBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self subject installCode.
	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	self assert: self subject getterSource equals: 'foos
	^ self slotVarNamed: ''foos'''
]
