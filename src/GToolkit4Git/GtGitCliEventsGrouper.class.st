Class {
	#name : 'GtGitCliEventsGrouper',
	#superclass : 'GtBeaconEventsGrouper',
	#category : 'GToolkit4Git-Libgit-CLI-GT',
	#package : 'GToolkit4Git',
	#tag : 'Libgit-CLI-GT'
}

{ #category : 'accessing' }
GtGitCliEventsGrouper >> createDefaultEventsGroup [
	^GtGitCliEventsGroup new
]
