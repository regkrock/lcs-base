Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-SystemTests'
}

{ #category : #running }
LcsSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
