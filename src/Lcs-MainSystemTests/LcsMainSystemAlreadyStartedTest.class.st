Class {
	#name : #LcsMainSystemAlreadyStartedTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #running }
LcsMainSystemAlreadyStartedTest >> setupSunitSystem [
	LcsMainSystem new
]
