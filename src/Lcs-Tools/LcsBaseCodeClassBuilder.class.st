Class {
	#name : #LcsBaseCodeClassBuilder,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'installedClass',
		'rootName',
		'installClassName',
		'classPrefix',
		'codePackageName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsBaseCodeClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #'instance  creation' }
LcsBaseCodeClassBuilder class >> newRootName: aString [ 
	^ self new
		initializeRootName: aString;
		yourself
]

{ #category : #build }
LcsBaseCodeClassBuilder >> addCompletedRefactoring: aRefactoring [ 
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> classPrefix [
	^ classPrefix
]

{ #category : #acessing }
LcsBaseCodeClassBuilder >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> codeClassDefintion [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self superclassName
			with: self installClassName
			with: self codePackageName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codePackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codePackageName: aString [
	codePackageName := aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #initialize }
LcsBaseCodeClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #initialize }
LcsBaseCodeClassBuilder >> initializeRootName: aString [ 
	self rootName: aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> install [
	self addCompletedRefactoring: (RBAddClassChange definition: self codeClassDefintion) execute.
	self installedClass: self completedRefactorings last changeClass.

	self assert: self installedClass notNil.
	self assert: self installedClass category = self codePackageName
]

{ #category : #build }
LcsBaseCodeClassBuilder >> installClassName [
	^ installClassName
		ifNil: [ installClassName := self classPrefix , self rootName ]
]

{ #category : #build }
LcsBaseCodeClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #build }
LcsBaseCodeClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> superclassName [
	self subclassResponsibility
]
