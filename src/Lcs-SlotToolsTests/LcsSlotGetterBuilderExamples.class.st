Class {
	#name : 'LcsSlotGetterBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSlotGetterBuilderExamples >> foosGetterBuilder [
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
LcsSlotGetterBuilderExamples >> installAndRemoveGetter [
	<gtExample>
	| builder |
	builder := self foosGetterBuilder.
	self deny: (self currentSystem class canUnderstand: 'foos' asSymbol).
	self deny: (self currentSystem class canUnderstand: 'foos:' asSymbol).
	[
	  builder installCode.
  	self assert: (self currentSystem class canUnderstand: 'foos' asSymbol).
	  builder verifyCodeInstallation]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			self deny: (self currentSystem class canUnderstand: 'foos' asSymbol) ]
]

{ #category : 'examples' }
LcsSlotGetterBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSlotGetterBuilder new.
	^ builder
]

{ #category : 'examples' }
LcsSlotGetterBuilderExamples >> slotDefinitionAccessorMethods [
	<gtExample>
	| builder |
	builder := self foosGetterBuilder.
	self assert: builder refactoringText equals: 'foos
	^ self slotVarNamed: ''foos''
'.	
	^ builder refactoringText
]

{ #category : 'tests' }
LcsSlotGetterBuilderExamples >> testInstallingGetter [
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
