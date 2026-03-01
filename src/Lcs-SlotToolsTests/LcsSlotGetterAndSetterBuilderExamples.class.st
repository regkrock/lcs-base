Class {
	#name : 'LcsSlotGetterAndSetterBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSlotGetterAndSetterBuilderExamples >> foosGetterAndSetterBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder
				slotName: 'foos';
				targetClassName: self currentSystem class name;
				yourself.
	builder buildJobSteps.
	self assert: builder jobSteps isEmpty.
	^ builder
]

{ #category : 'examples' }
LcsSlotGetterAndSetterBuilderExamples >> installAndRemoveGetterAndSetter [
	<gtExample>
	| builder |
	builder := self foosGetterAndSetterBuilder.
	self deny: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	[
	  builder installCode.
  	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol).
	  self assert: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	  builder verifyCodeInstallation]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			self deny: (self currentSystem class canUnderstand: 'foos' asSymbol).
			self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol)]
]

{ #category : 'examples' }
LcsSlotGetterAndSetterBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSlotGetterAndSetterBuilder new.
	^ builder
]

{ #category : 'examples' }
LcsSlotGetterAndSetterBuilderExamples >> slotDefinitionAccessorMethods [
	<gtExample>
	| builder |
	builder := self foosGetterAndSetterBuilder.
	self assert: builder refactoringText equals: 'foos
	^ self slotVarNamed: ''foos''

foos: anObject
	self slotVarNamed: ''foos'' put: anObject'.	
	^ builder refactoringText
]
