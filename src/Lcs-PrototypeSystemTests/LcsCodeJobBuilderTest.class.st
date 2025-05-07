Class {
	#name : #LcsCodeJobBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #accessing }
LcsCodeJobBuilderTest >> codeJobBuilder [
	^ codeJobBuilder
]

{ #category : #accessing }
LcsCodeJobBuilderTest >> codeJobBuilder: anObject [
	codeJobBuilder := anObject
]

{ #category : #'setUp\t' }
LcsCodeJobBuilderTest >> tearDown [
	self codeJobBuilder ifNotNil: [ :builder | builder uninstall].
	super tearDown.
	self codeJobBuilder ifNotNil: [ :builder | builder verifyUninstall]
]
