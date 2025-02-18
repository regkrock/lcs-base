Class {
	#name : #LcsAllSubmodulesVisitor,
	#superclass : #LcsObject,
	#instVars : [
		'visited',
		'submodules'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'instance creation' }
LcsAllSubmodulesVisitor class >> allSubmodulesFor: aModuleClass [
	^ self new 
		submodulesFor: aModuleClass;
		submodules
]

{ #category : #api }
LcsAllSubmodulesVisitor >> _submodulesFor: aModuleClass [
	LcsBaseModule
		allSubclassesDo: [ :eachClass | 
			(eachClass isSubmoduleOf: aModuleClass)
				ifTrue: [ self submodules add: eachClass.
					self submodulesFor: eachClass ] ]
]

{ #category : #'as yet unclassified' }
LcsAllSubmodulesVisitor >> initialize [ 
	super initialize.
	self visited: Set new.
	self submodules: OrderedCollection new.
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
LcsAllSubmodulesVisitor >> visited [
	^ visited
]

{ #category : #accessing }
LcsAllSubmodulesVisitor >> visited: anObject [
	visited := anObject
]
