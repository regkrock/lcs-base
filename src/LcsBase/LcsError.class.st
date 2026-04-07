Class {
	#name : 'LcsError',
	#superclass : 'Error',
	#instVars : [
		'smalltalkException'
	],
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'system' }
LcsError >> currentSystem [
	^ #LcsApplicationEnvironment asClass currentSystem
]

{ #category : 'accessing' }
LcsError >> smalltalkException [
	^ smalltalkException
]

{ #category : 'accessing' }
LcsError >> smalltalkException: anObject [
	smalltalkException := anObject
]
