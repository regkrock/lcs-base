Extension { #name : 'LcsObjectExamples' }

{ #category : '*Lcs-PrototypeSystemTests' }
LcsObjectExamples >> createNewPrototypeSystem [
	^ LcsApplicationEnvironment createNewPrototypeSystem
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsObjectExamples >> ensureCurrentSystemIsPrototypeSystem [
	self savedSystem: self currentSystem.
	^ LcsApplicationEnvironment ensureCurrentSystemIs: LxxPrototypeSystem
]

{ #category : '*Lcs-PrototypeSystemTests' }
LcsObjectExamples >> ensureCurrentSystemIsPrototypeSystemWithLogging [
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
