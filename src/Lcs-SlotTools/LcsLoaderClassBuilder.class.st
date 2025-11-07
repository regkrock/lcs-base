Class {
	#name : #LcsLoaderClassBuilder,
	#superclass : #LcsBaseClassBuilder,
	#instVars : [
		'instanceClassName',
		'unknownClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsLoaderClassBuilder class >> targetSuperclassName [	
	^ 'LcsObjectsLoader'
]

{ #category : #build }
LcsLoaderClassBuilder >> _installCode [
	super _installCode.
	self installClass.
	self installDataMethod.
	self installTargetClassMethod.
	self installUnkownClassMethod.
	self beCodeInstalled
]

{ #category : #verification }
LcsLoaderClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self class targetSuperclassName
]

{ #category : #printing }
LcsLoaderClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream cr; cr.
	aStream nextPutAll: self targetClassMethodSource; cr; cr..
	self unknownClassName notNil ifTrue: [
		aStream nextPutAll: self unknownClassMethodSource; cr; cr].
	aStream nextPutAll: self dataMethodSource
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

{ #category : #initialize }
LcsLoaderClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self targetSuperclassName
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
	self assert: self instanceClassName notNil.
	self addRefactoring: (
		RBAddMethodChange
			compile: self targetClassMethodSource
			in: self installedClass
			classified: #configuration) execute.
]

{ #category : #build }
LcsLoaderClassBuilder >> installUnkownClassMethod [
	self unknownClassName isNil ifTrue: [ ^self ].
	self addRefactoring: (
		RBAddMethodChange
			compile: self unknownClassMethodSource
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

{ #category : #build }
LcsLoaderClassBuilder >> unknownClassMethodSource [
	^ 'unknownClass	
	^ ' , self unknownClassName
]

{ #category : #accessing }
LcsLoaderClassBuilder >> unknownClassName [
	^ unknownClassName
]

{ #category : #accessing }
LcsLoaderClassBuilder >> unknownClassName: anObject [
	unknownClassName := anObject
]

{ #category : #command }
LcsLoaderClassBuilder >> updateSlotModel [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifyClassAddedToSystemModel [
	"Currently the loader is not part of model."
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	"Currently the loader is not part of model."
	self traceStep: 'verifySlotModelUpdatesMadeByBuilder'.
]

{ #category : #verification }
LcsLoaderClassBuilder >> verifyUninstall [
	super verifyUninstall.
	self assert: self installedClass isNil
]
