Class {
	#name : #LcsPrototypeSystemTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #setUp }
LcsPrototypeSystemTest >> setupSunitSystem [
	^ #LxxPrototypeSystem asClass new
]
