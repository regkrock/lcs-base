Class {
	#name : 'GtGitRepositorySelected',
	#superclass : 'Announcement',
	#instVars : [
		'repository'
	],
	#category : 'GToolkit4Git-Announcements',
	#package : 'GToolkit4Git',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
GtGitRepositorySelected >> repository [
	^ repository
]

{ #category : 'accessing' }
GtGitRepositorySelected >> repository: aRepository [
	repository := aRepository
]
