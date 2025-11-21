Class {
	#name : 'GtGitStatusIncoming',
	#superclass : 'GtGitStatusWithCount',
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'accessing' }
GtGitStatusIncoming class >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : 'accessing' }
GtGitStatusIncoming >> bareIcon [
	^ BrGlamorousVectorIcons down
]

{ #category : 'accessing' }
GtGitStatusIncoming >> label [
	^ count asString, ' incoming ', self changesInflection
]
