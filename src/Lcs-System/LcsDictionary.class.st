Class {
	#name : #LcsDictionary,
	#superclass : #LcsCollection,
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsDictionary >> collectionClass [
	^LcsSmalltalkConfiguration stringDictionaryClass
]
