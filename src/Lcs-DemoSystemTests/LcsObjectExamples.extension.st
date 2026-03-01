Extension { #name : 'LcsObjectExamples' }

{ #category : '*Lcs-DemoSystemTests' }
LcsObjectExamples >> createNewDemoSystem [
	^ LcsApplicationEnvironment createNewDemoSystem
]

{ #category : '*Lcs-DemoSystemTests' }
LcsObjectExamples >> ensureCurrentSystemIsDemoSystem [
	self savedSystem: self currentSystem.
	^ LcsApplicationEnvironment ensureCurrentSystemIs: LcsDemoSystem
]

{ #category : '*Lcs-DemoSystemTests' }
LcsObjectExamples >> ensureCurrentSystemIsDemoSystemWithLogging [
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
