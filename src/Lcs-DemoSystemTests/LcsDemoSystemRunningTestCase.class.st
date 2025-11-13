Class {
	#name : #LcsDemoSystemRunningTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-DemoSystemTests'
}

{ #category : #running }
LcsDemoSystemRunningTestCase >> setupSunitSystem [
	LcsDemoSystem new
]
