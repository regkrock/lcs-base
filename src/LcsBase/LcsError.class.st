Class {
	#name : 'LcsError',
	#superclass : 'Error',
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'as yet unclassified' }
LcsError >> currentSystem [
	^ #LcsApplicationEnvironment asClass currentSystem
]
