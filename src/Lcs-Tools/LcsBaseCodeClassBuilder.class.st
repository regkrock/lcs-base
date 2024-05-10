Class {
	#name : #LcsBaseCodeClassBuilder,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'installedClass',
		'rootName',
		'installClassName',
		'classPrefix',
		'codePackageName',
		'shortName',
		'codeDescription',
		'codeName'
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
LcsBaseCodeClassBuilder >> addCodeDescriptionRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeDescriptionSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #build }
LcsBaseCodeClassBuilder >> addCodeNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeNameSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #build }
LcsBaseCodeClassBuilder >> addCompletedRefactoring: aRefactoring [ 
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #build }
LcsBaseCodeClassBuilder >> addShortNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultShortNameSource
		in: self installedClass class
		classified: #defaults
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

{ #category : #build }
LcsBaseCodeClassBuilder >> codeDescription [
	^ codeDescription ifNil: [ self rootName ]
]

{ #category : #build }
LcsBaseCodeClassBuilder >> codeDescription: aString [
	codeDescription := aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> codeName [
	^ codeName
		ifNil: [ self rootName first asLowercase asString
				, (self rootName copyFrom: 2 to: self rootName size) ]
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

{ #category : #build }
LcsBaseCodeClassBuilder >> defaultCodeDescriptionSource [
	^ 'defaultCodeDescription
	^ ''' , self codeDescription , ''''
]

{ #category : #build }
LcsBaseCodeClassBuilder >> defaultCodeNameSource [
	^ 'defaultCodeName
	^ ''' , (self codeName first asLowercase asString) , (self codeName copyFrom: 2 to: self codeName size) , ''''
]

{ #category : #build }
LcsBaseCodeClassBuilder >> defaultShortNameSource [
	^ 'defaultShortName
	^ ''' , self shortName , ''''
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
	self installedClass: self completedRefactorings last changeClass
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
LcsBaseCodeClassBuilder >> shortName [
	^ shortName ifNil: [ self rootName ]
]

{ #category : #build }
LcsBaseCodeClassBuilder >> superclassName [
	self subclassResponsibility
]
