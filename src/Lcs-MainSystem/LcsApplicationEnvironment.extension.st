Extension { #name : #LcsApplicationEnvironment }

{ #category : #'*Lcs-MainSystem' }
LcsApplicationEnvironment class >> createNewMainSystem [
	^ self createNewSystem: LcsMainSystem
]

{ #category : #'*Lcs-MainSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsMainSystem [
	self ensureCurrentSystemIs: LcsMainSystem
]
