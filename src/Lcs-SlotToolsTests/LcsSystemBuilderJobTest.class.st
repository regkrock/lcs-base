Class {
	#name : 'LcsSystemBuilderJobTest',
	#superclass : 'LcsCodeJobBuilderTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'examples' }
LcsSystemBuilderJobTest >> clubSystemBuilderExample [
	<gtExample>
	| job |
	job := LcsSystemBuilderJob new.
	job 
		classPrefix: 'Lxx';
		createForRootName:'ClubSystem';
		moduleName: 'Club System';
		buildJobSteps.

	self assert: (self classNamed: 'LxxClubSystem') isNil.
	self assert: (self classNamed: 'LxxClubSystemConfiguration') isNil.
	self deny: (LcsModule respondsTo: #clubSystem).

	^ job
]

{ #category : 'tests' }
LcsSystemBuilderJobTest >> testCreationOfNewSystem [
	| a |
	a := OrderedCollection new.
	self subject: self clubSystemBuilderExample.

	self subject installCode.

	self assert: (self classNamed: 'LxxClubSystem') notNil.
	self assert: (self classNamed: 'LxxClubSystemConfiguration') notNil.
	self assert: (LcsModule canUnderstand: #clubSystem).
	self deny: ((self classNamed: 'LxxClubSystem') respondsTo: #owningModules).
	
	self subject uninstall.

	self assert: (self classNamed: 'LxxClubSystem') isNil.
	self assert: (self classNamed: 'LxxClubSystemConfiguration') isNil.
	self deny: (LcsModule canUnderstand: #clubSystem)
]
