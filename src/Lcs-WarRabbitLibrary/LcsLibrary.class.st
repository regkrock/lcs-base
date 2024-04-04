Class {
	#name : #LcsLibrary,
	#superclass : #LcsObject,
	#instVars : [
		'categories',
		'items',
		'authors'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsLibrary >> authors [
	^ authors
]

{ #category : #accessing }
LcsLibrary >> authors: anObject [
	authors := anObject
]

{ #category : #accessing }
LcsLibrary >> categories [
	^ categories
]

{ #category : #accessing }
LcsLibrary >> categories: anObject [
	categories := anObject
]

{ #category : #accessing }
LcsLibrary >> initialize [
	super initialize.
	self categories: Dictionary new.
	self authors: Set new.
	self items: IdentitySet new
	
		
]

{ #category : #accessing }
LcsLibrary >> items [
	^ items
]

{ #category : #accessing }
LcsLibrary >> items: anObject [
	items := anObject
]
