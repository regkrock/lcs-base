Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsSystemTestCase >> setupSunitSystem [
	LcsSystemManager createMainSystem
]
