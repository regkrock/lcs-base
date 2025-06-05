Class {
	#name : #LcsClassModel,
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
LcsClassModel >> addAssociation: aName toClassModelNamed: aClassModelName [
	| association |
	association := LcsAssociationModel new
						fromClassModel: self;
						toClassModelName: aClassModelName;
						associationName: aName.
	^ self associations add: association
]

{ #category : #api }
LcsClassModel >> addAssociation: aName toModel: aModel [
	| association |
	association := LcsAssociationModel new
						fromClassModel: self;
						toClassModel: aModel;
						associationName: aName.
	^ self associations add: association
]

{ #category : #api }
LcsClassModel >> addAssociation: aName toModelNamed: aModelClassname [
	Transcript tab.
	self traceCr: 'Adding association ' , aName , ' from ' , self modelClassname asString , ' to ' , aModelClassname. 
	
	^ self addAssociation: aName toClassModelNamed: aModelClassname
]

{ #category : #accessing }
LcsClassModel >> associations [
	^ associations
]

{ #category : #accessing }
LcsClassModel >> associations: anObject [
	associations := anObject
]

{ #category : #'as yet unclassified' }
LcsClassModel >> initialize [ 
	super initialize.
	self associations: OrderedCollection new
]

{ #category : #testing }
LcsClassModel >> isModelSuperclassOf: aModel [
	^ self modelClassname asString = aModel modelSuperclassName asString
]

{ #category : #'as yet unclassified' }
LcsClassModel >> modelClass [
	^ [ self modelClassname asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsClassModel >> modelClassname [
	^ modelClassname
]

{ #category : #accessing }
LcsClassModel >> modelClassname: anObject [
	modelClassname := anObject
]

{ #category : #accessing }
LcsClassModel >> modelSuperclass [
	^ modelSuperclass
]

{ #category : #accessing }
LcsClassModel >> modelSuperclass: anObject [
	modelSuperclass := anObject
]

{ #category : #accessing }
LcsClassModel >> modelSuperclassName [
	^ modelSuperclassName
]

{ #category : #'gt views' }
LcsClassModel >> modelSuperclassName: aString [ 
	modelSuperclassName := aString
]
