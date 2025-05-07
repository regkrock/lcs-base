Class {
	#name : #LcsLoaderClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#instVars : [
		'instanceClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsLoaderClassBuilder class >> targetSuperclassName [	
	^ 'LcsObjectLoader'
]

{ #category : #printing }
LcsLoaderClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream cr; cr.
	aStream nextPutAll: self targetClassMethodSource.
	aStream cr; cr.
	aStream nextPutAll: self dataMethodSource.
	
]

{ #category : #build }
LcsLoaderClassBuilder >> dataMethodSource [
	^ 'data
	^ ''<1s>''' expandMacrosWith: self dataString
]

{ #category : #build }
LcsLoaderClassBuilder >> dataString [
	^''
]

{ #category : #build }
LcsLoaderClassBuilder >> installCode [
	self installClass.
	self installDataMethod.
	self installTargetClassMethod.
	self beCodeInstalled
]

{ #category : #build }
LcsLoaderClassBuilder >> installDataMethod [
	self addRefactoring: (
		RBAddMethodChange
			compile: self dataMethodSource
			in: self installedClass
			classified: #data) execute.
]

{ #category : #build }
LcsLoaderClassBuilder >> installTargetClassMethod [
	self addRefactoring: (
		RBAddMethodChange
			compile: self targetClassMethodSource
			in: self installedClass
			classified: #configuration) execute.
]

{ #category : #accessing }
LcsLoaderClassBuilder >> instanceClassName [
	^ instanceClassName
]

{ #category : #accessing }
LcsLoaderClassBuilder >> instanceClassName: anObject [
	instanceClassName := anObject
]

{ #category : #build }
LcsLoaderClassBuilder >> targetClassMethodSource [
	^ 'targetClass
	^ ' , self instanceClassName
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifyClassAddedToSystemModel [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self class targetSuperclassName
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifyUnistall [
	super verifyUnistall.
	self assert: self installedClass isNil
]
