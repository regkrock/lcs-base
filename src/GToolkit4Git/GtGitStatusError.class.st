Class {
	#name : 'GtGitStatusError',
	#superclass : 'GtGitStatus',
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'accessing' }
GtGitStatusError class >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : 'accessing' }
GtGitStatusError >> icon [
	^ BrGlamorousVectorIcons cancel
]
