Class {
	#name : 'LcsSlotGetterAndSetterBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsSlotGetterAndSetterBuilderTest >> testInstallingGetterAndSetter [
	self deny: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	self subject: (
		LcsSlotGetterAndSetterBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self subject installCode.
	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self assert: (self currentSystem class canUnderstand: 'foos:' asSymbol)
]
