Class {
	#name : #LcsCodeBuilderJobSteps,
	#superclass : #LcsCollection,
	#instVars : [
		'classPrefix',
		'codePackageName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeBuilderJobSteps class >> collectionClass [
	^OrderedCollection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> addCompletedRefactoring: aRefactoring [
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> addJobStep: aJobStep [
	aJobStep parent: self.
	self collection add: aJobStep
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix: aString [
	^ classPrefix := aString
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> codePackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> install [
	self collection do: [ :each | each install ]
]
