Class {
	#name : 'LcsObjectExamples',
	#superclass : 'LcsObject',
	#instVars : [
		'subject'
	],
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'system support' }
LcsObjectExamples >> clearUnitOfWork [
	self currentSystem isNil ifTrue: [ ^ self ].
	self currentSystem clearUnitOfWork
]

{ #category : 'system support' }
LcsObjectExamples >> createNewDemoSystem [
	^ LcsApplicationEnvironment createNewDemoSystem
]

{ #category : 'system support' }
LcsObjectExamples >> createNewPrototypeSystem [
	^ LcsApplicationEnvironment createNewPrototypeSystem
]

{ #category : 'system support' }
LcsObjectExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : 'system support' }
LcsObjectExamples >> ensureCurrentSystemIsDemoSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIsDemoSystem
]

{ #category : 'system support' }
LcsObjectExamples >> ensureCurrentSystemIsPrototypeSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem
]

{ #category : 'system support' }
LcsObjectExamples >> ensureCurrentSystemIsSailingClubSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIs: LcsSailingClubSystem
]

{ #category : 'system support' }
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

{ #category : 'system support' }
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

{ #category : 'assertions  - support' }
LcsObjectExamples >> executeShould: aBlock inScopeOf: anExceptionalEvent [
	^ [ aBlock value.
		false ] on: anExceptionalEvent do: [ :ex | ex return: true ]
]

{ #category : 'assertions  - support' }
LcsObjectExamples >> executeShouldnt: aBlock inScopeOf: anExceptionalEvent [
	^ [ aBlock value.
		true ] on: anExceptionalEvent do: [ :ex | ex return: false ]
]

{ #category : 'system support' }
LcsObjectExamples >> removeCurrentSystem [
	^ LcsApplicationEnvironment removeCurrentSystem
]

{ #category : 'assertions' }
LcsObjectExamples >> should: aBlock raise: anExceptionalEvent [
	^ self assert: (self executeShould: aBlock inScopeOf: anExceptionalEvent)
]

{ #category : 'assertions' }
LcsObjectExamples >> shouldnt: aBlock raise: anExceptionalEvent [
	^ self assert: (self executeShouldnt: aBlock inScopeOf: anExceptionalEvent)
]

{ #category : 'accessing' }
LcsObjectExamples >> subject [
	^ subject
]

{ #category : 'accessing' }
LcsObjectExamples >> subject: anObject [
	subject := anObject
]
