Class {
	#name : 'GtGitStatusUnknownError',
	#superclass : 'GtGitStatusError',
	#instVars : [
		'message'
	],
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'accessing' }
GtGitStatusUnknownError >> label [
	^ self message
]

{ #category : 'accessing' }
GtGitStatusUnknownError >> message [
	^ message
]

{ #category : 'accessing' }
GtGitStatusUnknownError >> message: aString [
	message := aString
]
