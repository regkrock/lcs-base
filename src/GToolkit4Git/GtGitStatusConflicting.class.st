Class {
	#name : 'GtGitStatusConflicting',
	#superclass : 'GtGitStatusIncoming',
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'accessing' }
GtGitStatusConflicting class >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : 'accessing' }
GtGitStatusConflicting >> label [
	^ count asString, ' conflicting incoming ', self changesInflection
]
