Extension { #name : #LcsApplicationEnvironment }

{ #category : #'*Lcs-DemoSystem' }
LcsApplicationEnvironment class >> createNewDemoSystem [
	^ self createNewSystem: LcsDemoSystem
]

{ #category : #'*Lcs-DemoSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsDemoSystem [
	self ensureCurrentSystemIs: LcsDemoSystem
]
