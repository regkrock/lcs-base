Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsSystemTestCase >> setUp [
	super setUp.
	LcsSystemManager createNewSystem
]
