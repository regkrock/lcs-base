Class {
	#name : 'LcsPrototypeSystemRunningTest',
	#superclass : 'LcsTestWithTestSystemSetUpForTest',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'setUp' }
LcsPrototypeSystemRunningTest >> setupSunitSystem [
	LxxPrototypeSystem new
]
