Extension { #name : #LcsApplicationEnvironment }

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironment class >> createNewPrototypeSystem [
	| prototypeSystem |
	System abortTransaction.
	self ensureInitialized.
	prototypeSystem := self createCurrentSystemFor: LxxPrototypeSystem.
	System commitTransaction.
	^ prototypeSystem
]
