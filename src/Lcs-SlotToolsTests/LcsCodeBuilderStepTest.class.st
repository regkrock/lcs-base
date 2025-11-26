Class {
	#name : 'LcsCodeBuilderStepTest',
	#superclass : 'LcsCodeBuilderTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'setUp' }
LcsCodeBuilderStepTest >> tearDown [
	self subject notNil ifTrue: [
		self subject uninstall.
		self subject verifyUninstall ].
	super tearDown
]
