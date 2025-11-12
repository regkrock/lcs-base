Extension { #name : #LcsApplicationEnvironment }

{ #category : #'*Lcs-MainSystem' }
LcsApplicationEnvironment class >> createNewDemoSystem [
	^ self createNewSystem: LcsDemoSystem
]

{ #category : #'*Lcs-MainSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsDemoSystem [
	self ensureCurrentSystemIs: LcsDemoSystem
]
