Class {
	#name : 'LcsAssociationModel',
	#superclass : 'LcsObject',
	#instVars : [
		'fromClassModel',
		'toClassModel',
		'associationName',
		'factor'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsAssociationModel >> associationName [
	^ associationName
]

{ #category : 'accessing' }
LcsAssociationModel >> associationName: anObject [
	associationName := anObject
]

{ #category : 'accessing' }
LcsAssociationModel >> factor [
	^ factor
]

{ #category : 'accessing' }
LcsAssociationModel >> factor: aNumber [
	factor := aNumber
]

{ #category : 'accessing' }
LcsAssociationModel >> fromClassModel [
	^ fromClassModel
]

{ #category : 'accessing' }
LcsAssociationModel >> fromClassModel: anObject [
	fromClassModel := anObject
]

{ #category : 'accessing' }
LcsAssociationModel >> fromClassModelName [
	^ self fromClassModel modelClassname
]

{ #category : 'initialize' }
LcsAssociationModel >> initialize [
	super initialize.
	self factor: 0.2
]

{ #category : 'accessing' }
LcsAssociationModel >> toClassModel [
	^ toClassModel
]

{ #category : 'accessing' }
LcsAssociationModel >> toClassModel: anObject [
	toClassModel := anObject
]

{ #category : 'accessing' }
LcsAssociationModel >> toClassModelName [
	^ self toClassModel modelClassname
]
