Class {
	#name : #LcsLibraryCategory,
	#superclass : #LcsObject,
	#instVars : [
		'categoryName'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsLibraryCategory class >> newFor: aString [
	^ self new
		categoryName: aString;
		yourself 
	
]

{ #category : #accessing }
LcsLibraryCategory >> categoryName [
	^ categoryName
]

{ #category : #accessing }
LcsLibraryCategory >> categoryName: anObject [
	categoryName := anObject
]
