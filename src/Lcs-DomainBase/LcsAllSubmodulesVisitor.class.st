Class {
	#name : #LcsAllSubmodulesVisitor,
	#superclass : #LcsObject,
	#instVars : [
		'visited',
		'submodules',
		'targetModule',
		'potentialModules'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'instance creation' }
LcsAllSubmodulesVisitor class >> allSubmodulesFor: aModule [
	^ (self newOn: aModule) allSubmodules
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
			self submodules add: eachClass.
			self submodulesFor: eachClass ] ]
]

{ #category : #api }
LcsAllSubmodulesVisitor >> allSubmodules [
	self submodulesFor: self targetModule.
	^ self submodules
]

{ #category : #initialize }
LcsAllSubmodulesVisitor >> initialize [ 
	super initialize.
	self visited: Set new.
	self submodules: OrderedCollection new.
	potentialModules := LcsBaseModule allOwnedModuleCandidates.
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
	self _submodulesFor: aModuleClass
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
