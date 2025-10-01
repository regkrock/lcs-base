Extension { #name : #LcsApplicationEnvironment }

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewMainSystem [
	^ self createNewSystem: LcsMainSystem
]

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewPrototypeSystem [
	^ self createNewSystem: LxxPrototypeSystem
]

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewSystem: aSystemClass [
	| system |
	System abortTransaction.
	self ensureInitialized.
	system := self createCurrentSystemFor: aSystemClass.
	System commitTransaction.
	^ system
]
