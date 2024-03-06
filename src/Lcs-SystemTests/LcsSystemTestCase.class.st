Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsSystemTestCase >> setUp [
	super setUp.
	LcsSystemManager createNewSystem
]
