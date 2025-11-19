Class {
	#name : 'LcsSingletonValueObjectClassBuilder',
	#superclass : 'LcsValueObjectClassBuilder',
	#instVars : [
		'label',
		'code',
		'description'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'install' }
LcsSingletonValueObjectClassBuilder >> _installCode [
	super _installCode.
	self addRefactoring: self addDefaultLabelRefactoring execute.
	self addRefactoring: self addDefaultDescriptionRefactoring execute.
	self addRefactoring: self addDefaultCodeRefactoring execute.
	self addRefactoring: self addDefaultInstanceRefactoring execute.
	self beCodeInstalled
]

{ #category : 'verification' }
LcsSingletonValueObjectClassBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self targetSuperclassName.
	self assert: self installedClass defaultDescription equals: self description.
	self assert: self installedClass defaultCode equals: self code.
	self assert: self installedClass defaultLabel equals: self label.
]

{ #category : 'refactoring' }
LcsSingletonValueObjectClassBuilder >> addDefaultCodeRefactoring [
	^ RBAddMethodChange
		compile: self defaultCodeSource
		in: self installedClass class
		classified: #defaults
]

{ #category : 'refactoring' }
LcsSingletonValueObjectClassBuilder >> addDefaultDescriptionRefactoring [
	^ RBAddMethodChange
		compile: self defaultDescriptionSource
		in: self installedClass class
		classified: #defaults
]

{ #category : 'refactoring' }
LcsSingletonValueObjectClassBuilder >> addDefaultInstanceRefactoring [
	^ RBAddMethodChange
		compile: self defaultInstanceSource
		in: self installedClass class
		classified: #defaults
]

{ #category : 'refactoring' }
LcsSingletonValueObjectClassBuilder >> addDefaultLabelRefactoring [
	^ RBAddMethodChange
		compile: self defaultLabelSource
		in: self installedClass class
		classified: #defaults
]

{ #category : 'printing' }
LcsSingletonValueObjectClassBuilder >> addRefactoringTextDetailsTo: aStream [
	super addRefactoringTextDetailsTo: aStream.
	aStream 
		cr; cr; nextPutAll: 'Create Class Methods:';
		cr; cr; nextPutAll: self defaultCodeSource;
		cr; cr; nextPutAll: self defaultDescriptionSource;
		cr; cr; nextPutAll: self defaultLabelSource;
		cr; cr; nextPutAll: self defaultDescriptionSource
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> code [
	^ code
		ifNil: [ self description first asLowercase asString
				, (self description copyFrom: 2 to: self rootName size) ]
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> code: aString [
	code := aString
]

{ #category : 'private' }
LcsSingletonValueObjectClassBuilder >> defaultCode [
	^ self code first asLowercase asString
		, (self code copyFrom: 2 to: self code size)
]

{ #category : 'method code source' }
LcsSingletonValueObjectClassBuilder >> defaultCodeSource [
	^ 'defaultCode
	^ ' ,self defaultCode printString
]

{ #category : 'method code source' }
LcsSingletonValueObjectClassBuilder >> defaultDescriptionSource [
	^ 'defaultDescription
	^ ''' , self description , ''''
]

{ #category : 'method code source' }
LcsSingletonValueObjectClassBuilder >> defaultInstanceSource [
	^ 'defaultInstance
	^ ' , self defaultInstance asString
]

{ #category : 'method code source' }
LcsSingletonValueObjectClassBuilder >> defaultLabelSource [
	^ 'defaultLabel
	^ ''' , self label , ''''
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> description [
	^ description ifNil: [ description := self rootName ]
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> description: aString [
	description := aString
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> label [ 
	^ label ifNil: [ label := self description ]
]

{ #category : 'accessing' }
LcsSingletonValueObjectClassBuilder >> label: aString [
	label := aString
]
