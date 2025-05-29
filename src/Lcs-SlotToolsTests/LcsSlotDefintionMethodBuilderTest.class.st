Class {
	#name : #LcsSlotDefintionMethodBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#instVars : [
		'codeBuilder'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSlotDefintionMethodBuilderTest >> testInstallingSlotDefinitionMethod [
	self subject: (
		LcsSlotDefintionMethodBuilder new
			slotName: 'foos';
			slotDefinitionClass: LcsStringSlot;
			targetClassName: self currentSystem class name;
			yourself).
	self subject installCode.
	self assert: (self currentSystem class respondsTo: ('foos' , 'SlotDefinition') asSymbol)
]
