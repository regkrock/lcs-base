Class {
	#name : #LcsBaseClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'shortName',
		'codeDescription',
		'codeName',
		'newClassName',
		'targetPackageName',
		'targetSuperclassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsBaseClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #accessing }
LcsBaseClassBuilder class >> targetSuperclassName [
	^ nil
]

{ #category : #refactoring }
LcsBaseClassBuilder >> addCompletedRefactoring: aRefactoring [ 
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #template }
LcsBaseClassBuilder >> codeClassDefintion [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self targetSuperclassName
			with: self newClassName
			with: self targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> codeDescription [
	^ codeDescription ifNil: [ codeDescription := self rootName ]
]

{ #category : #accessing }
LcsBaseClassBuilder >> codeDescription: aString [
	codeDescription := aString
]

{ #category : #build }
LcsBaseClassBuilder >> codeName [
	^ codeName
		ifNil: [ self rootName first asLowercase asString
				, (self rootName copyFrom: 2 to: self rootName size) ]
]

{ #category : #build }
LcsBaseClassBuilder >> codeName: aString [
	codeName := aString
]

{ #category : #refactoring }
LcsBaseClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #initialize }
LcsBaseClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName
]

{ #category : #initialize }
LcsBaseClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseClassBuilder >> installCode [
	self addCompletedRefactoring: (RBAddClassChange definition: self codeClassDefintion) execute.
	self installedClass: self completedRefactorings last changeClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> jobSteps [
	^ OrderedCollection new
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> shortName [
	^ shortName ifNil: [ shortName := self rootName ]
]

{ #category : #accessing }
LcsBaseClassBuilder >> shortName: aString [
	shortName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName: aString [
	targetPackageName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName [
	^ targetSuperclassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName: aString [
	targetSuperclassName := aString
]

{ #category : #install }
LcsBaseClassBuilder >> updateSlotModel [
	self installedClass initializeSlotModel
]

{ #category : #install }
LcsBaseClassBuilder >> verifyCodeInstallation [
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self assert: self installedClass slotModel isNil description: 'The class has been created but not yet installed in a system'
]

{ #category : #install }
LcsBaseClassBuilder >> verifySlotModelUpdates [
	self assert: self installedClass slotModel  notNil.
	self assert: (self currentSystem systemSlotModel hasSlotModelFor: self installedClass)
]
