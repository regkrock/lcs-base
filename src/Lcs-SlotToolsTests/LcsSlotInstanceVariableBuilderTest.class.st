Class {
	#name : #LcsSlotInstanceVariableBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSlotInstanceVariableBuilderTest >> testInstallingSlot [
	self subject: (
		LcsSlotInstanceVariableBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	self subject installCode.
	self assert: (self currentSystem class instVarNames includes: 'foos')
]
