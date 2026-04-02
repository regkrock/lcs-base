"
Subclasses of this class will suspend the current application environment during setUp. It will be restored during tearDown.

The subclasses of this test then have a 'pristine' environment to test the creation of the application environment and its operation without interfeering with the existing Application Environment
"
Class {
	#name : 'LcsNoApplicationEnvironmentExamples',
	#superclass : 'LcsTestCase',
	#instVars : [
		'currentApplicationEnvironment'
	],
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'accessing' }
LcsNoApplicationEnvironmentExamples >> currentApplicationEnvironment [
	^currentApplicationEnvironment
]

{ #category : 'accessing' }
LcsNoApplicationEnvironmentExamples >> currentApplicationEnvironment: anApplicationEnvironment [ 
	currentApplicationEnvironment := anApplicationEnvironment
]

{ #category : 'running' }
LcsNoApplicationEnvironmentExamples >> setUp [
	self abortTransaction. 
	self currentApplicationEnvironment: LcsApplicationEnvironment suspendApplicationEnvironment.
	self deny: LcsApplicationEnvironment hasInitializedApplicationEnvironment.
	self commitTransaction
]

{ #category : 'running' }
LcsNoApplicationEnvironmentExamples >> tearDown [
	self abortTransaction. 
	LcsApplicationEnvironment restoreToCurrentApplicationEnvironment: self currentApplicationEnvironment.
	LcsApplicationEnvironment hasInitializedApplicationEnvironment ifTrue: [
	self assert: LcsApplicationEnvironment isInActiveStatus].
	self commitTransaction
]
