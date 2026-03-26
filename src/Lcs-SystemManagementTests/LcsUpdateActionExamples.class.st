Class {
	#name : 'LcsUpdateActionExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUpdateActionExamples >> newPostAddAction [
	<gtExample>
	| updateAction |
	updateAction := LcsUpdateAction new.
	self assert: updateAction parent isNil.
	self assert: updateAction description equals: ''.
	self assert: updateAction actionBlock printString equals: updateAction defaultActionBlock printString.
	self assert: updateAction errorDescription equals: 'LcsUpdateAction - Error:'.
	self assert: updateAction asCreationString equals: '(LcsUpdateAction new
			actionBlock: [ :value |  ];
			description: '''')'.
	^ updateAction
]

{ #category : 'examples - errors' }
LcsUpdateActionExamples >> slotActionExecutionError [
	<gtExample>
	<noTest>
	| updateAction |
	updateAction := self newPostAddAction.
	updateAction actionBlock: [ :value :domainObject :oldValue | domainObject + value ].
	self should: [updateAction execute: 12 context: 'aDomainObject' oldValue: 'anOldValue' ] raise: LcsSlotActionExecutionError .
	^ updateAction execute: 12 context: 'aDomainObject' oldValue: 'anOldValue'
]
