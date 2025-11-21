Class {
	#name : 'GtGitIceChangeImporter',
	#superclass : 'IceChangeImporter',
	#category : 'GToolkit4Git-Model',
	#package : 'GToolkit4Git',
	#tag : 'Model'
}

{ #category : 'visiting' }
GtGitIceChangeImporter >> visitGitChange: anIceGitChange [ 

	| importer |
	importer := GtGitInsideGitChangeImporter new
		path: anIceGitChange path;
		diff: diff;
		version: version;
		yourself.
	importer importOn: parentNode.
]
