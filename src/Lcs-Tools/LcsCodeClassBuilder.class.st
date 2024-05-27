Class {
	#name : #LcsCodeClassBuilder,
	#superclass : #LcsBaseCodeClassBuilder,
	#instVars : [
		'defaultInstance'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsCodeClassBuilder >> beDefaultInstance [
	defaultInstance := true
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance [
	^ defaultInstance
]

{ #category : #accessing }
LcsCodeClassBuilder >> defaultInstance: aBoolean [ 
	defaultInstance := aBoolean
]

{ #category : #initialize }
LcsCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: false
]

{ #category : #build }
LcsCodeClassBuilder >> installCode [
	super installCode.
	self addCompletedRefactoring: self addShortNameRefactoring execute.
	self addCompletedRefactoring: self addCodeDescriptionRefactoring execute.
	self addCompletedRefactoring: self addCodeNameRefactoring execute.
]

{ #category : #testing }
LcsCodeClassBuilder >> isDefaultInstance [
	^ self defaultInstance == true
]

{ #category : #accessing }
LcsCodeClassBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.
	self assert: self installedClass superclass name equals: self superclassName.
	self assert: self installedClass defaultCodeDescription equals: self codeDescription.
	self assert: self installedClass defaultCodeName equals: self codeName.
	self assert: self installedClass defaultShortName equals: self shortName.
]
