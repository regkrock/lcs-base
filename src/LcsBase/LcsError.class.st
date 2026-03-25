Class {
	#name : 'LcsError',
	#superclass : 'Error',
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'system' }
LcsError >> currentSystem [
	^ #LcsApplicationEnvironment asClass currentSystem
]
