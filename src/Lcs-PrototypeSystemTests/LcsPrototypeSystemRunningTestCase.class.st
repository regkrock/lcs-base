Class {
	#name : #LcsPrototypeSystemRunningTestCase,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #setUp }
LcsPrototypeSystemRunningTestCase >> setupSunitSystem [
	LxxPrototypeSystem new
]
