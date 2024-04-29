Class {
	#name : #LcsClassesBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'classPrefix',
		'codePackageName',
		'completedRefactorings',
		'jobSteps'
	],
	#category : #'Lcs-Tools'
}

{ #category : #build }
LcsClassesBuilderJob >> addCompletedRefactoring: aRefactoring [ 
	self completedRefactorings add: aRefactoring
]

{ #category : #accessing }
LcsClassesBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsClassesBuilderJob >> classPrefix: anObject [
	classPrefix := anObject
]

{ #category : #accessing }
LcsClassesBuilderJob >> codePackageName [
	^ codePackageName
]

{ #category : #acccessing }
LcsClassesBuilderJob >> codePackageName: aString [ 
	codePackageName := aString
]

{ #category : #accessing }
LcsClassesBuilderJob >> completedRefactorings [
	^ completedRefactorings
]

{ #category : #accessing }
LcsClassesBuilderJob >> completedRefactorings: anObject [
	completedRefactorings := anObject
]

{ #category : #initial }
LcsClassesBuilderJob >> initialize [
	super initialize.
	self
		jobSteps: OrderedCollection new;
		classPrefix: 'Lcs';
		completedRefactorings: OrderedCollection new.
]

{ #category : #configuration }
LcsClassesBuilderJob >> installCodesInPackageNamed: aString [ 
	self codePackageName: aString
]

{ #category : #accessing }
LcsClassesBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsClassesBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]
