Class {
	#name : #LcsMainSystemTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #running }
LcsMainSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
