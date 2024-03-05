Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsTestCase >> currentSystem [
	^LcsSystemManager currentSystem
]

{ #category : #accessing }
LcsTestCase >> setUp [
	super setUp.
	LcsSystem newSystem
]
