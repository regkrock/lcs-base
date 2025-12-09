Class {
	#name : 'LcsPostRemoveActionExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPostRemoveActionExamples >> newPostRemvoeAction [
	<gtExample>
	| postRemoveAction |
	postRemoveAction := LcsPostRemoveAction new.
	self assert: postRemoveAction parent isNil.
	self assert: postRemoveAction description equals: ''.
	self assert: postRemoveAction actionBlock printString equals: postRemoveAction defaultActionBlock printString.
	self assert: postRemoveAction errorDescription equals: 'LcsPostRemoveAction - Error:'.
	self assert: postRemoveAction asCreationString equals: '(LcsPostRemoveAction new
			actionBlock: [ :value |  ];
			description: '''')'.
	^ postRemoveAction
]
