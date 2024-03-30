"
All application test classes should inherit from this class
"
Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #running }
LcsTestCase >> abortTransaction [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction
]

{ #category : #running }
LcsTestCase >> beginTransaction [
	LcsSmalltalkConfiguration gsSystemClass beginTransaction
]

{ #category : #running }
LcsTestCase >> commitTransaction [
	LcsSmalltalkConfiguration gsSystemClass commitTransaction
]
