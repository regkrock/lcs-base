Class {
	#name : #LcsAllSubmodulesVisitor,
	#superclass : #LcsObject,
	#instVars : [
		'visited',
		'submodules',
		'targetModule',
		'potentialModules',
		'collectionPolicy'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'instance creation' }
LcsAllSubmodulesVisitor class >> allSubmodulesFor: aModule [
	^ (self newOn: aModule) allSubmoduleClasses
]

{ #category : #'instance creation' }
LcsAllSubmodulesVisitor class >> immediateSubmodulesFor: aModule [
	^ (self newOn: aModule) immediateSubmoduleClasses
]

{ #category : #'instance creation' }
LcsAllSubmodulesVisitor class >> newOn: aModule [ 
	^ self basicNew
		initializeOn: aModule;
		yourself
]

{ #category : #api }
LcsAllSubmodulesVisitor >> _submodulesFor: aModuleClass [
	self potentialModules do: [ :eachClass | 
		(eachClass isSubmoduleOf: aModuleClass) ifTrue: [ 
			self submodules add: eachClass ] ].
	self hasCollectAllPolicy ifTrue: [
		self searchForSubmodulesOfFoundSubmodules].
]

{ #category : #api }
LcsAllSubmodulesVisitor >> allSubmoduleClasses [
	self submodulesFor: self targetModule.
	^ self submodules
]

{ #category : #configuration }
LcsAllSubmodulesVisitor >> beCollectAllModules [
	self collectionPolicy: #all 
]

{ #category : #configuration }
LcsAllSubmodulesVisitor >> beCollectOnlyImmediateModules [
	self collectionPolicy: #immediate 
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> collectionPolicy [
	^ collectionPolicy
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> collectionPolicy: aString [ 
	collectionPolicy := aString
]

{ #category : #testing }
LcsAllSubmodulesVisitor >> hasCollectAllPolicy [
	^ self collectionPolicy == #all 
]

{ #category : #testing }
LcsAllSubmodulesVisitor >> hasRecursiveModules [
	^ self submodules includes: self targetModule
]

{ #category : #api }
LcsAllSubmodulesVisitor >> immediateSubmoduleClasses [
	self beCollectOnlyImmediateModules.
	self submodulesFor: self targetModule.
	^ self submodules
]

{ #category : #initialize }
LcsAllSubmodulesVisitor >> initialize [ 
	super initialize.
	self visited: Set new.
	self submodules: OrderedCollection new.
	self potentialModules: LcsModule allOwnedModuleCandidates.
	self beCollectAllModules.
]

{ #category : #initialize }
LcsAllSubmodulesVisitor >> initializeOn: aModule [ 
	self initialize.
	self targetModule: aModule
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> potentialModules [
	^ potentialModules
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> potentialModules: anObject [
	potentialModules := anObject
]

{ #category : #api }
LcsAllSubmodulesVisitor >> searchForSubmodulesOfFoundSubmodules [
	self submodules copy do: [ :eachClass | | visitor |
		visitor := self copy
					targetModule: eachClass;
					submodules: OrderedCollection new.
		self submodules addAll: (visitor submodulesFor: eachClass) submodules.
		"(self submodules includes: visitor targetModule) ifTrue: [ visitor signalRecursiveError]" ] 
]

{ #category : #testing }
LcsAllSubmodulesVisitor >> signalErrorIfRecursiveModulesExist [
	^ self hasRecursiveModules ifTrue: [ self signalRecursiveError ]
]

{ #category : #api }
LcsAllSubmodulesVisitor >> signalRecursiveError [
	LcsModuleHierarchyError signalModuleRecursingToItself: self targetModule name
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> submodules [
	^ submodules
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> submodules: anObject [
	submodules := anObject
]

{ #category : #api }
LcsAllSubmodulesVisitor >> submodulesFor: aModuleClass [
	(self visited includes: aModuleClass) ifTrue: [ ^ self ].
	self visited add: aModuleClass.
	self _submodulesFor: aModuleClass.
	self hasRecursiveModules ifTrue: [ self signalRecursiveError ]
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> targetModule [
	^ targetModule
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> targetModule: aModule [ 
	targetModule := aModule
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> visited [
	^ visited
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> visited: anObject [
	visited := anObject
]
