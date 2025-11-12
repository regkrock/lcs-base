Class {
	#name : #LcsObjectExamples,
	#superclass : #LcsObject,
	#category : #'Lcs-BaseTests-Examples'
}

{ #category : #'as yet unclassified' }
LcsObjectExamples >> createNewDemoSystem [
	^ LcsApplicationEnvironment createNewDemoSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> createNewPrototypeSystem [
	^ LcsApplicationEnvironment createNewPrototypeSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #support }
LcsObjectExamples >> ensureCurrentSystemIsDemoSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIsDemoSystem
]

{ #category : #support }
LcsObjectExamples >> ensureCurrentSystemIsPrototypeSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> ensureCurrentsystemIsDemoSystemWithLogging [
	"<gtExample>"
	| callingMethodName |
	callingMethodName := thisContext sender method selector copy.
	Transcript crShow: thisContext method selector.
	Transcript cr; tab; show: callingMethodName.
	Transcript cr; tab; tab; show: 'Number of Systems: ' , LcsApplicationEnvironment systemsManager numberOfSystems asString.
	callingMethodName asString = 'primitiveProcessExample:withEvaluationContext:'
		ifTrue: [" Transcript show: thisContext stackString" ]
		ifFalse: [ 
			Transcript cr; tab; tab; show: '... about to test current system'.
			self currentSystem
				ifNil: [ 
					Transcript cr; tab; tab; show: '... current system is nil - crete new system'.
					self createNewPrototypeSystem ]
				ifNotNil: [ 
					self currentSystem isDemoSystem
						ifFalse: [ 
							Transcript cr; tab; tab;
								show: '... current system is not prototype system - crete new system'.
							self createNewDemoSystem ] ] ].
	self assert: self currentSystem isDemoSystem.
	Transcript cr; tab; tab; show: 'Number of Systems: '
				, LcsApplicationEnvironment systemsManager numberOfSystems asString.
	Transcript crShow: '-----'.
	^ self currentSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> ensureCurrentsystemIsPrototypeSystemWithLogging [
	"<gtExample>"
	| callingMethodName |
	callingMethodName := thisContext sender method selector copy.
	Transcript crShow: thisContext method selector.
	Transcript cr; tab; show: callingMethodName.
	Transcript cr; tab; tab; show: 'Number of Systems: ' , LcsApplicationEnvironment systemsManager numberOfSystems asString.
	callingMethodName asString = 'primitiveProcessExample:withEvaluationContext:'
		ifTrue: [" Transcript show: thisContext stackString" ]
		ifFalse: [ 
			Transcript cr; tab; tab; show: '... about to test current system'.
			self currentSystem
				ifNil: [ 
					Transcript cr; tab; tab; show: '... current system is nil - crete new system'.
					self createNewPrototypeSystem ]
				ifNotNil: [ 
					self currentSystem isPrototypeSystem
						ifFalse: [ 
							Transcript cr; tab; tab;
								show: '... current system is not prototype system - crete new system'.
							self createNewPrototypeSystem ] ] ].
	self assert: self currentSystem isPrototypeSystem.
	Transcript cr; tab; tab; show: 'Number of Systems: '
				, LcsApplicationEnvironment systemsManager numberOfSystems asString.
	Transcript crShow: '-----'.
	^ self currentSystem
]

{ #category : #'as yet unclassified' }
LcsObjectExamples >> removeCurrentSystem [
	^ LcsApplicationEnvironment removeCurrentSystem
]
