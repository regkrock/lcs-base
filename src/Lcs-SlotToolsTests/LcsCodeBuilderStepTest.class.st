Class {
	#name : #LcsCodeBuilderStepTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #setUp }
LcsCodeBuilderStepTest >> tearDown [
	self subject notNil ifTrue: [
		self subject uninstall.
		self subject verifyUninstall ].
	super tearDown
]
