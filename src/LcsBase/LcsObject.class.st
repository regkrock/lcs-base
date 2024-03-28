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

{ #category : #accessing }
LcsObject >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '( id: ';
		nextPutAll: self hash printString;
		nextPutAll: ')'

]
