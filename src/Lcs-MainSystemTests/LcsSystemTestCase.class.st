Class {
	#name : #LcsSystemTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #running }
LcsSystemTestCase >> setupSunitSystem [
	LcsMainSystem new
]
