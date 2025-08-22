Class {
	#name : #LcsObjectExamples,
	#superclass : #LcsObject,
	#category : #'Lcs-BaseTests-Examples'
}

{ #category : #'as yet unclassified' }
LcsObjectExamples >> createNewPrototypeSystem [
	<gtExample>
	^ LcsApplicationEnvironment createNewPrototypeSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> ensureCurrentsystemIsPrototypeSystem [
	<gtExample>
	self currentSystem 
		ifNil: [ self createNewPrototypeSystem ]
		ifNotNil: [ self currentSystem isPrototypeSystem ifFalse: [ self createNewPrototypeSystem ] ].
	self assert: self currentSystem isPrototypeSystem.
	^ self currentSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> removeCurrentSystem [
	^ LcsApplicationEnvironment removeCurrentSystem
]
