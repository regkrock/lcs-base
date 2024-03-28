Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #'running\t' }
LcsSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
