"
Subclasses in:
1)  the  setUp phase of this test will suspend and save the current system.
2) the tearDwon phase will restore the suspended system.

No test system will be created in the setUp phase.

This is designed for tests that are testing the actual construction of a system

"
Class {
	#name : 'LcsTestWithNoTestSystemSetupForTest',
	#superclass : 'LcsAbstractDomainTest',
	#instVars : [
		'additionalSubject'
	],
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'accessing' }
LcsTestWithNoTestSystemSetupForTest >> additionalSubject [
	^ additionalSubject
]

{ #category : 'accessing' }
LcsTestWithNoTestSystemSetupForTest >> additionalSubject: anObject [
	additionalSubject := anObject 
]

{ #category : 'running' }
LcsTestWithNoTestSystemSetupForTest >> setUp [
	super setUp.
	self assert: self currentSystem isNil
]

{ #category : 'running' }
LcsTestWithNoTestSystemSetupForTest >> tearDown [
	self subject ifNotNil: [ 
		self subject removeSystem.
		self subject: nil ].
	self additionalSubject ifNotNil: [ 
		self additionalSubject removeSystem.
		self additionalSubject: nil ].
	super tearDown

]
