Class {
	#name : 'LcsPostAddActionExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPostAddActionExamples >> newPostAddAction [
	<gtExample>
	| postAddAction |
	postAddAction := LcsPostAddAction new.
	self assert: postAddAction parent isNil.
	self assert: postAddAction description isEmpty.
	self assert: postAddAction actionBlock printString equals: postAddAction defaultActionBlock printString.
	self assert: postAddAction errorDescription equals: 'LcsPostAddAction - Error:'.
	self assert: postAddAction asCreationString equals: '(LcsPostAddAction new
			actionBlock: [ :value |  ];
			description: '''')'.
	^ postAddAction
]
