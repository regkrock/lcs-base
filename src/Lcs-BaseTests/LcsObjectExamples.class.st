Class {
	#name : #LcsObjectExamples,
	#superclass : #LcsObject,
	#category : #'Lcs-BaseTests-Examples'
}

{ #category : #'as yet unclassified' }
LcsObjectExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]
