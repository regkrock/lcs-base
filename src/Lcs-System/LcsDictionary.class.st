Class {
	#name : #LcsDictionary,
	#superclass : #LcsCollection,
	#category : #'Lcs-System'
}

{ #category : #defaults }
LcsDictionary >> collectionClass [
	^ LcsSmalltalkConfiguration stringDictionaryClass
]
