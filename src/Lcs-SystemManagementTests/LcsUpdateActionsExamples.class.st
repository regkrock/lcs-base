Class {
	#name : 'LcsUpdateActionsExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUpdateActionsExamples >> newUpdateActions [
	<gtExample>
	| updateActions |
	updateActions := LcsUpdateActions new.
	self assert: updateActions collection isEmpty.
	self assert: updateActions parent isNil.
	^ updateActions
]
