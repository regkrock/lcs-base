Class {
	#name : #LcsUnknownCodeClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsUnknownCodeClassBuilderTest >> testCreation [
	self subject: LcsUnknownCodeClassBuilder new.
	self subject newClassName: 'XxxTest'.
	self subject targetSuperclassName: 'LcsObject'.
	self subject targetPackageName: 'PkgName'.
	
	self assert: self subject defaultInstance = true.
	self assert: self subject description = ''.
	self assert: self subject label = ''.
	self assert: self subject code = 'unknown'.
	self assert: self subject newClassName = 'XxxTest'.
	self assert: self subject classCreationString equals: 'LcsObject subclass: #XxxTest
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''PkgName'' '
]
