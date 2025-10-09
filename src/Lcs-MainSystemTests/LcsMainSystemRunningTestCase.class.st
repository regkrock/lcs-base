Class {
	#name : #LcsMainSystemRunningTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #running }
LcsMainSystemRunningTestCase >> setupSunitSystem [
	LcsMainSystem new
]
