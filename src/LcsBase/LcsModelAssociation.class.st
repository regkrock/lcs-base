Class {
	#name : #LcsModelAssociation,
	#superclass : #LcsObject,
	#instVars : [
		'fromClassModel',
		'toClassModel',
		'asoociationName'
	],
	#category : #'LcsBase-Core'
}

{ #category : #accessing }
LcsModelAssociation >> asoociationName [
	^ asoociationName
]

{ #category : #accessing }
LcsModelAssociation >> asoociationName: anObject [
	asoociationName := anObject
]

{ #category : #accessing }
LcsModelAssociation >> fromClassModel [
	^ fromClassModel
]

{ #category : #accessing }
LcsModelAssociation >> fromClassModel: anObject [
	fromClassModel := anObject
]

{ #category : #accessing }
LcsModelAssociation >> toClassModel [
	^ toClassModel
]

{ #category : #accessing }
LcsModelAssociation >> toClassModel: anObject [
	toClassModel := anObject
]
