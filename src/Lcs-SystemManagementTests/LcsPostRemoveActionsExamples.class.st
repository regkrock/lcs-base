Class {
	#name : 'LcsPostRemoveActionsExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPostRemoveActionsExamples >> newPostRemoveActions [
	<gtExample>
	| postRemoveActions |
	postRemoveActions := LcsPostRemoveActions new.
	self assert: postRemoveActions collection isEmpty.
	self assert: postRemoveActions parent isNil.
	^ postRemoveActions
]
