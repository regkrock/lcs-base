Class {
	#name : #LcsUnknownGender,
	#superclass : #LcsGender,
	#category : #'Lcs-LegalEntities'
}

{ #category : #defaults }
LcsUnknownGender class >> defaultCode [
	^ 'unknownGender'
]

{ #category : #defaults }
LcsUnknownGender class >> defaultDescription [
	^ 'UnknownGender'
]

{ #category : #defaults }
LcsUnknownGender class >> defaultInstance [
	^ true
]

{ #category : #defaults }
LcsUnknownGender class >> defaultLabel [
	^ 'UnknownGender'
]
