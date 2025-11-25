Class {
	#name : 'LcsPrototypeSystemRunningTestCase',
	#superclass : 'LcsTestWithTestSystemSetUpForTest',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'setUp' }
LcsPrototypeSystemRunningTestCase >> setupSunitSystem [
	LxxPrototypeSystem new
]
