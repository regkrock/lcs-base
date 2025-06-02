Class {
	#name : #LcsModelClass,
	#superclass : #LcsObject,
	#instVars : [
		'modelClassname',
		'modelSuperclassName',
		'modelSuperclass',
		'associations'
	],
	#category : #'LcsBase-Core'
}

{ #category : #api }
LcsModelClass >> addAssociation: aName toModel: aModel [
	| association |
	association := LcsModelAssociation new
						fromClassModel: self;
						toClassModel: aModel;
						asoociationName: aName.
	self associations add: association
]

{ #category : #api }
LcsModelClass >> addAssociation: aName toModelNamed: aModelClassName [
]

{ #category : #accessing }
LcsModelClass >> associations [
	^ associations
]

{ #category : #accessing }
LcsModelClass >> associations: anObject [
	associations := anObject
]

{ #category : #'as yet unclassified' }
LcsModelClass >> initialize [ 
	super initialize.
	self associations: OrderedCollection new
]

{ #category : #testing }
LcsModelClass >> isModelSuperclassOf: aModel [
	^ self modelClassname asString = aModel modelSuperclassName
]

{ #category : #'as yet unclassified' }
LcsModelClass >> modelClass [
	^ [ self modelClassname asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsModelClass >> modelClassname [
	^ modelClassname
]

{ #category : #accessing }
LcsModelClass >> modelClassname: anObject [
	modelClassname := anObject
]

{ #category : #accessing }
LcsModelClass >> modelSuperclass [
	^ modelSuperclass
]

{ #category : #accessing }
LcsModelClass >> modelSuperclass: anObject [
	modelSuperclass := anObject
]

{ #category : #accessing }
LcsModelClass >> modelSuperclassName [
	^ modelSuperclassName
]

{ #category : #'gt views' }
LcsModelClass >> modelSuperclassName: aString [ 
	modelSuperclassName := aString
]
