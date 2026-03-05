Class {
	#name : 'LcsPostAddActionsExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPostAddActionsExamples >> newPostAddActions [
	<gtExample>
	| postAddActions |
	postAddActions := LcsPostAddActions new.
	self assert: postAddActions collection isEmpty.
	self assert: postAddActions parent isNil.
	^ postAddActions
]
