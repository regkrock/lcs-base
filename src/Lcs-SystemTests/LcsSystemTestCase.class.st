Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #running }
LcsSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
