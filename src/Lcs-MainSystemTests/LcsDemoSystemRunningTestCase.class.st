Class {
	#name : #LcsDemoSystemRunningTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #running }
LcsDemoSystemRunningTestCase >> setupSunitSystem [
	LcsDemoSystem new
]
