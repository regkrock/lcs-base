Class {
	#name : #LcsSlotGetterAndSetterBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSlotGetterAndSetterBuilderTest >> testInstallingGetterAndSetter [
	self subject: (
		LcsSlotGetterAndSetterBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self subject installCode.
	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol)
]
