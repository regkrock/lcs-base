Extension { #name : 'LcsApplicationEnvironment' }

{ #category : '*Lcs-DemoSystem' }
LcsApplicationEnvironment class >> createNewDemoSystem [
	^ self createNewSystem: LcsDemoSystem
]

{ #category : '*Lcs-DemoSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsBasicSystem [
	self ensureCurrentSystemIs: LcsBasicSystem
]

{ #category : '*Lcs-DemoSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsDemoSystem [
	self ensureCurrentSystemIs: LcsDemoSystem
]
