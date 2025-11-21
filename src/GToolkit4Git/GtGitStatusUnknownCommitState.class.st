Class {
	#name : 'GtGitStatusUnknownCommitState',
	#superclass : 'GtGitStatusWithMessage',
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'accessing' }
GtGitStatusUnknownCommitState class >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : 'accessing' }
GtGitStatusUnknownCommitState >> icon [
	^ BrGlamorousVectorIcons cancel
]
