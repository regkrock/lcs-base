"
Subclasses of this class will suspend the current application environment during setUp. It will be restored during tearDown.

The subclasses of this test then have a 'pristine' environment to test the creation of the application environment and its operation without interfeering with the existing Application Environment
"
Class {
	#name : #LcsBaseApplicationEnvironmentTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'currentApplicationEnvironment'
	],
	#category : #'Lcs-SystemManagementTests-Tests'
}

{ #category : #accessing }
LcsBaseApplicationEnvironmentTest >> currentApplicationEnvironment [
	^currentApplicationEnvironment
]

{ #category : #acccessing }
LcsBaseApplicationEnvironmentTest >> currentApplicationEnvironment: anApplicationEnvironment [ 
	currentApplicationEnvironment := anApplicationEnvironment
]

{ #category : #running }
LcsBaseApplicationEnvironmentTest >> setUp [
	self abortTransaction. 
	super setUp.
	self currentApplicationEnvironment: LcsApplicationEnvironment suspendCurrentApplicationEnvironment.
	self commitTransaction
]

{ #category : #running }
LcsBaseApplicationEnvironmentTest >> tearDown [
	self abortTransaction. 
	super tearDown.
	LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: self currentApplicationEnvironment.
	LcsApplicationEnvironment hasInitializedApplicationEnvironment ifTrue: [
	self assert: LcsApplicationEnvironment isInActiveStatus].
	self commitTransaction
]
