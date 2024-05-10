Class {
	#name : #LcsCodes,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase'
}

{ #category : #accessing }
LcsCodes >> defaultInstance [
	^self collection detect: [ :each | each isDefaultInstance == true]
]
