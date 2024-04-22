Class {
	#name : #LcsCodeBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'classPrefix',
		'codePackageName',
		'completedRefactorings'
	],
	#category : #'Lcs-Tools'
}

{ #category : #build }
LcsCodeBuilderJob >> addCompletedRefactoring: aRefactoring [ 
	self completedRefactorings add: aRefactoring
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix: anObject [
	classPrefix := anObject
]

{ #category : #accessing }
LcsCodeBuilderJob >> codePackageName [
	^ codePackageName
]

{ #category : #configuration }
LcsCodeBuilderJob >> codePackageName: aString [ 
	codePackageName := aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> completedRefactorings [
	^ completedRefactorings
]

{ #category : #accessing }
LcsCodeBuilderJob >> completedRefactorings: anObject [
	completedRefactorings := anObject
]

{ #category : #initial }
LcsCodeBuilderJob >> initialize [
	super initialize.
	self
		classPrefix: 'Lcs';
		completedRefactorings: OrderedCollection new.
]

{ #category : #configuration }
LcsCodeBuilderJob >> installCodesInPackageNamed: aString [ 
	self codePackageName: aString
]
