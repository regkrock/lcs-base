Class {
	#name : 'LcsBasicSystemExamples',
	#superclass : 'LcsBaseSystemExamples',
	#category : 'Lcs-BaseSystemExamples-Examples',
	#package : 'Lcs-BaseSystemExamples',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsBasicSystemExamples >> basicSystem [
	<gtExample>
	self subject: (LcsApplicationEnvironment ensureCurrentSystemIs: LcsBasicSystem).
	self assertCurrentSystemSetTo: LcsBasicSystem.
	self assertModuleConfigured: LcsSecurityModule.
	^ self currentSystem
]

{ #category : 'exmples' }
LcsBasicSystemExamples >> createNewBasicSystemWhenCurrentSystemIsNil [
	<gtExample>
	| savedSystem |
	savedSystem := self currentSystem.
	LcsApplicationEnvironment suspendCurrentSystem.
	self assert: self currentSystem isNil.
	(savedSystem isKindOf: LcsBasicSystem)
		ifTrue: [ LcsApplicationEnvironment systemsManager systems remove: savedSystem.
			self
				deny: (LcsApplicationEnvironment systemsManager systems includes: savedSystem).
			self
				assert: (LcsApplicationEnvironment systemsManager suspendedSystemFor: LcsBasicSystem)
						isNil ].

	self subject: (LcsApplicationEnvironment ensureCurrentSystemIs: LcsBasicSystem).

	self assertCurrentSystemSetTo: LcsBasicSystem.
	self assertModuleConfigured: LcsSecurityModule.
	LcsApplicationEnvironment systemsManager removeCurrentSystem.
	savedSystem
		ifNotNil: [ (LcsApplicationEnvironment systemsManager systems includes: savedSystem)
				ifFalse: [ LcsApplicationEnvironment systemsManager systems add: savedSystem ] ].
	LcsApplicationEnvironment removeCurrentSystem.
	savedSystem ifNotNil: [ savedSystem restoreSystem ].
	self assert: self currentSystem identicalTo: savedSystem.
	savedSystem notNil
		ifTrue: [ self
				assert: (LcsApplicationEnvironment systemsManager systems
						select: [ :each | each == savedSystem ]) size = 1 ].
	^ self currentSystem
]

{ #category : 'exmples' }
LcsBasicSystemExamples >> newBasicSystem [
	"The new system becomes the current system"
	self subject: LcsBasicSystem new.
	self assertCurrentSystemSetTo: LcsBasicSystem.
	self assertModuleConfigured: LcsSecurityModule.
	^ self subject
]
