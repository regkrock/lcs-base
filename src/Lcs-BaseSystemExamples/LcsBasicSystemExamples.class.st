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
	<gtExample>
	| system originalSystem  |
	originalSystem := self ensureNoCurrentSystem.
	[ 
		self assert: self currentSystem isNil.
		system := LcsBasicSystem new.
		self assertCurrentSystemSetTo: LcsBasicSystem.
		self assertModuleConfigured: LcsSecurityModule.
		]
			ensure: [
				self removeCurrentSystemAndActivate: originalSystem ].
	self assert: self currentSystem identicalTo: originalSystem.
	^ system
]

{ #category : 'exmples' }
LcsBasicSystemExamples >> unitOfWorkWithNewObject [
	<gtExample>
	| domainObject |
	self ensureCurrentSystemIsBasicSystem.
	self clearUnitOfWork.
	domainObject := LcsDomainObject new.
	self assert: self currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: (self currentUnitOfWork addedObjects keys includes:  domainObject).
	self clearUnitOfWork
]
