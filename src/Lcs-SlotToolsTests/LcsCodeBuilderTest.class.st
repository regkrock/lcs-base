Class {
	#name : #LcsCodeBuilderTest,
	#superclass : #LcsPrototypeSystemRunningTestCase,
	#instVars : [
		'codeBuilderJobs',
		'currentCodeBuilderJob'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #accessing }
LcsCodeBuilderTest >> codeBuilderJobs [
	^ codeBuilderJobs
]

{ #category : #accessing }
LcsCodeBuilderTest >> codeBuilderJobs: anObject [
	codeBuilderJobs := anObject
]

{ #category : #accessing }
LcsCodeBuilderTest >> currentCodeBuilderJob [
	^ currentCodeBuilderJob
]

{ #category : #accessing }
LcsCodeBuilderTest >> currentCodeBuilderJob: anObject [
	currentCodeBuilderJob := anObject.
	self codeBuilderJobs add: anObject
]

{ #category : #setUp }
LcsCodeBuilderTest >> setUp [ 
	super setUp.
	self codeBuilderJobs: OrderedCollection new
]

{ #category : #'setUp\t' }
LcsCodeBuilderTest >> tearDown [
	self codeBuilderJobs reverseDo: [ :builder | builder uninstall].
	super tearDown.
	self codeBuilderJobs reverseDo: [ :builder | builder verifyUninstall]
]
