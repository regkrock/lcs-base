Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsDomainObjectTest >> setUp [
	super setUp
	LcsSystem clearSingleton.
	LcsSystem singleton.

]
