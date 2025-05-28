Class {
	#name : #LcsCodeJobBuilderTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeBuilderJobs',
		'currentCodeBuilderJob'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #accessing }
LcsCodeJobBuilderTest >> codeBuilderJobs [
	^ codeBuilderJobs
]

{ #category : #accessing }
LcsCodeJobBuilderTest >> codeBuilderJobs: anObject [
	codeBuilderJobs := anObject
]

{ #category : #accessing }
LcsCodeJobBuilderTest >> currentCodeBuilderJob [
	^ currentCodeBuilderJob
]

{ #category : #accessing }
LcsCodeJobBuilderTest >> currentCodeBuilderJob: anObject [
	currentCodeBuilderJob := anObject.
	self codeBuilderJobs add: anObject
]

{ #category : #setUp }
LcsCodeJobBuilderTest >> setUp [ 
	super setUp.
	self codeBuilderJobs: OrderedCollection new
]

{ #category : #'setUp\t' }
LcsCodeJobBuilderTest >> tearDown [
	self codeBuilderJobs reverseDo: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilderJobs reverseDo: [ :builder | builder verifyUninstall]
]
