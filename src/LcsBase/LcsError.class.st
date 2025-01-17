Class {
	#name : #LcsError,
	#superclass : #Error,
	#category : #LcsBase
}

{ #category : #'as yet unclassified' }
LcsError >> currentSystem [
	^ #LcsApplicationEnvironment asClass currentSystem
]
