Class {
	#name : #LcsSingletonCodeClassBuilder,
	#superclass : #LcsCodeClassBuilder,
	#instVars : [
		'label',
		'code',
		'description'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultCodeRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultDescriptionRefactoring [
	^ RBAddMethodChange
		compile: self defaultDescriptionSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultInstanceRefactoring [
	^ RBAddMethodChange
		compile: self defaultInstanceSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #refactoring }
LcsSingletonCodeClassBuilder >> addDefaultLabelRefactoring [
	^ RBAddMethodChange
		compile: self defaultLabelSource
		in: self installedClass class
		classified: #defaults
]

{ #category : #printing }
LcsSingletonCodeClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream 
		cr; cr; nextPutAll: 'Create Class Methods:';
		cr; cr; nextPutAll: self defaultCodeSource;
		cr; cr; nextPutAll: self defaultDescriptionSource;
		cr; cr; nextPutAll: self defaultLabelSource;
		cr; cr; nextPutAll: self defaultDescriptionSource
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> code [
	^ code
		ifNil: [ self description first asLowercase asString
				, (self description copyFrom: 2 to: self rootName size) ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> code: aString [
	code := aString
]

{ #category : #private }
LcsSingletonCodeClassBuilder >> defaultCode [
	^ self code first asLowercase asString
		, (self code copyFrom: 2 to: self code size)
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultCodeSource [
	^ 'defaultCode
	^ ' ,self defaultCode printString
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultDescriptionSource [
	^ 'defaultDescription
	^ ''' , self description , ''''
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultInstanceSource [
	^ 'defaultInstance
	^ ' , self defaultInstance asString
]

{ #category : #'method code source' }
LcsSingletonCodeClassBuilder >> defaultLabelSource [
	^ 'defaultLabel
	^ ''' , self label , ''''
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> description [
	^ description ifNil: [ description := self rootName ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> description: aString [
	description := aString
]

{ #category : #install }
LcsSingletonCodeClassBuilder >> installCode [
	super installCode.
	self addRefactoring: self addDefaultLabelRefactoring execute.
	self addRefactoring: self addDefaultDescriptionRefactoring execute.
	self addRefactoring: self addDefaultCodeRefactoring execute.
	self addRefactoring: self addDefaultInstanceRefactoring execute.
	self beCodeInstalled
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> label [ 
	^ label ifNil: [ label := self description ]
]

{ #category : #accessing }
LcsSingletonCodeClassBuilder >> label: aString [
	label := aString
]

{ #category : #verification }
LcsSingletonCodeClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName.
	self assert: self installedClass defaultDescription equals: self description.
	self assert: self installedClass defaultCode equals: self code.
	self assert: self installedClass defaultLabel equals: self label.
]
