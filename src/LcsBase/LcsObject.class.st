Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #'transactions ' }
LcsObject class >> abortTransaction [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction
]

{ #category : #transactions }
LcsObject class >> commitTransaction [
	LcsSmalltalkConfiguration gsSystemClass commitTransaction
]
