Extension { #name : 'LcsApplicationEnvironment' }

{ #category : '*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewPrototypeSystem [
	^ self createNewSystem: LxxPrototypeSystem
]

{ #category : '*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewSystem: aSystemClass [
	| system |
	System abortTransaction.
	self ensureInitialized.
	system := self createCurrentSystemFor: aSystemClass.
	System commitTransaction.
	^ system
]

{ #category : '*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> ensureCurrentSystemIsPrototypeSystem [
	self ensureCurrentSystemIs: LxxPrototypeSystem
]
