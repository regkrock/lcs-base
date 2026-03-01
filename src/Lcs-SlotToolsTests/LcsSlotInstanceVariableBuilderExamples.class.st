Class {
	#name : 'LcsSlotInstanceVariableBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#instVars : [
		'codeBuilder'
	],
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsSlotInstanceVariableBuilderExamples >> foosMethodBuilder [
	<gtExample>
	| builder |
	builder := (
		LcsSlotInstanceVariableBuilder new
			slotName: 'foos';
			targetClassName: self currentSystem class name;
			yourself).
	builder buildJobSteps.
	builder jobSteps isEmpty.
	^builder
]

{ #category : 'examples' }
LcsSlotInstanceVariableBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsSlotInstanceVariableBuilder new.
	^ builder
]

{ #category : 'examples' }
LcsSlotInstanceVariableBuilderExamples >> testInstallingSlot [
	<gtExample>
	| builder |
	builder := self foosMethodBuilder.
	self deny:(self currentSystem class instVarNames includes: 'foos').
	[
	  builder installCode.
	  self assert: (self currentSystem class instVarNames includes: 'foos').
	  builder verifyCodeInstallation. ]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			self deny:(self currentSystem class instVarNames includes: 'foos') ]
]
