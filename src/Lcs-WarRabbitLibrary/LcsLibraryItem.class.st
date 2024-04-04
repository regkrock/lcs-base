Class {
	#name : #LcsLibraryItem,
	#superclass : #LcsObject,
	#instVars : [
		'category'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsLibraryItem class >> newFor: line [ 
]

{ #category : #accessing }
LcsLibraryItem >> category [
	^ category
]

{ #category : #accessing }
LcsLibraryItem >> category: anObject [
	category := anObject
]
