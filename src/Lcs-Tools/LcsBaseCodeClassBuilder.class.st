Class {
	#name : #LcsBaseCodeClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'codePackageName',
		'shortName',
		'codeDescription',
		'codeName',
		'newClassName',
		'superclassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsBaseCodeClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #accessing }
LcsBaseCodeClassBuilder class >> superclassName [
	^ nil
]

{ #category : #refactoring }
LcsBaseCodeClassBuilder >> addCodeDescriptionRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeDescriptionSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsBaseCodeClassBuilder >> addCodeNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeNameSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsBaseCodeClassBuilder >> addCompletedRefactoring: aRefactoring [ 
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #refactoring }
LcsBaseCodeClassBuilder >> addShortNameRefactoring [
	^ RBAddMethodChange
		compile: self defaultShortNameSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #template }
LcsBaseCodeClassBuilder >> codeClassDefintion [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self superclassName
			with: self newClassName
			with: self codePackageName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codeDescription [
	^ codeDescription ifNil: [ codeDescription := self rootName ]
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codeDescription: aString [
	codeDescription := aString
]

{ #category : #build }
LcsBaseCodeClassBuilder >> codeName [
	^ codeName
		ifNil: [ self rootName first asLowercase asString
				, (self rootName copyFrom: 2 to: self rootName size) ]
]

{ #category : #build }
LcsBaseCodeClassBuilder >> codeName: aString [
	codeName := aString
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codePackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> codePackageName: aString [
	codePackageName := aString
]

{ #category : #refactoring }
LcsBaseCodeClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #'method source code' }
LcsBaseCodeClassBuilder >> defaultCodeDescriptionSource [
	^ 'defaultCodeDescription
	^ ''' , self codeDescription , ''''
]

{ #category : #private }
LcsBaseCodeClassBuilder >> defaultCodeName [
	^ self codeName first asLowercase asString
		, (self codeName copyFrom: 2 to: self codeName size)
]

{ #category : #'method source code' }
LcsBaseCodeClassBuilder >> defaultCodeNameSource [
	^ 'defaultCodeName
	^ ' ,self defaultCodeName printString
]

{ #category : #'method source code' }
LcsBaseCodeClassBuilder >> defaultShortNameSource [
	^ 'defaultShortName
	^ ''' , self shortName , ''''
]

{ #category : #initialize }
LcsBaseCodeClassBuilder >> initialize [
	super initialize.
	self superclassName: self class superclassName
]

{ #category : #initialize }
LcsBaseCodeClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseCodeClassBuilder >> installCode [
	self addCompletedRefactoring: (RBAddClassChange definition: self codeClassDefintion) execute.
	self installedClass: self completedRefactorings last changeClass
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> jobSteps [
	^ OrderedCollection new
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> shortName [
	^ shortName ifNil: [ shortName := self rootName ]
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> shortName: aString [
	shortName := aString
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> superclassName [
	^ superclassName
]

{ #category : #accessing }
LcsBaseCodeClassBuilder >> superclassName: aString [
	superclassName := aString
]

{ #category : #install }
LcsBaseCodeClassBuilder >> updateSlotModel [
	self installedClass initializeSlotModel
]

{ #category : #install }
LcsBaseCodeClassBuilder >> verifyInstallation [
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self assert: self installedClass slotModel isNil description: 'The class has been created but not yet installed in a system'
]

{ #category : #install }
LcsBaseCodeClassBuilder >> verifySlotModelUpdates [
	self assert: self installedClass slotModel  notNil.
	self assert: (self currentSystem systemSlotModel hasSlotModelFor: self installedClass)
]
