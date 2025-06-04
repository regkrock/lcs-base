Class {
	#name : #LcsAssociationModel,
	#superclass : #LcsObject,
	#instVars : [
		'fromClassModel',
		'toClassModel',
		'toClassModelName',
		'associationName'
	],
	#category : #'LcsBase-Core'
}

{ #category : #accessing }
LcsAssociationModel >> associationName [
	^ associationName
]

{ #category : #accessing }
LcsAssociationModel >> associationName: anObject [
	associationName := anObject
]

{ #category : #accessing }
LcsAssociationModel >> fromClassModel [
	^ fromClassModel
]

{ #category : #accessing }
LcsAssociationModel >> fromClassModel: anObject [
	fromClassModel := anObject
]

{ #category : #accessing }
LcsAssociationModel >> toClassModel [
	^ toClassModel
]

{ #category : #accessing }
LcsAssociationModel >> toClassModel: anObject [
	toClassModel := anObject
]

{ #category : #accessing }
LcsAssociationModel >> toClassModelName [
	^ toClassModelName
]

{ #category : #accessing }
LcsAssociationModel >> toClassModelName: aString [
	toClassModelName := aString
]
