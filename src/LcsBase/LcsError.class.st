Class {
	#name : #LcsError,
	#superclass : #Error,
	#category : #'LcsBase-Error'
}

{ #category : #'as yet unclassified' }
LcsError >> currentSystem [
	^ #LcsApplicationEnvironment asClass currentSystem
]
