Class {
	#name : #LcsModuleBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsModuleBuilderJobTest >> setUp [
	super setUp
]

{ #category : #tests }
LcsModuleBuilderJobTest >> testCreationOfNewModule [
	| a |
	a := OrderedCollection new.
	self subject: LcsModuleBuilderFormExamples new sailClubModuleExample.
	self assert: (self classNamed: 'LxxSailingClubModule') isNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') isNil.
	self deny: (LcsModule respondsTo: #sailingClubModule).

	self subject slotModelBuilder installCode.

	self assert: (self classNamed: 'LxxSailingClubModule') notNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') notNil.
	self assert: (LcsModule canUnderstand: #sailingClubModule).
	self assert: ((self classNamed: 'LxxSailingClubModule') respondsTo: #owningModules).
	
	self subject slotModelBuilder uninstall.

	self assert: (self classNamed: 'LxxSailingClubModule') isNil.
	self assert: (self classNamed: 'LxxSailingClubModuleConfiguration') isNil.
	self deny: (LcsModule canUnderstand: #sailingClubModule)
]
