Class {
	#name : #LcsAuthor,
	#superclass : #LcsObject,
	#instVars : [
		'surname',
		'firstName',
		'middleNames'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #accessing }
LcsAuthor >> firstName [
	^ firstName
]

{ #category : #accessing }
LcsAuthor >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
LcsAuthor >> middleNames [
	^ middleNames
]

{ #category : #accessing }
LcsAuthor >> middleNames: anObject [
	middleNames := anObject
]

{ #category : #accessing }
LcsAuthor >> surname [
	^ surname
]

{ #category : #accessing }
LcsAuthor >> surname: anObject [
	surname := anObject
]
