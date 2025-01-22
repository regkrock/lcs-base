Class {
	#name : #LcsPrototypeSystemTest,
	#superclass : #LcsTestWithTestSystemSetUpForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #setUp }
LcsPrototypeSystemTest >> setupSunitSystem [
	^ LxxPrototypeSystem new
]
