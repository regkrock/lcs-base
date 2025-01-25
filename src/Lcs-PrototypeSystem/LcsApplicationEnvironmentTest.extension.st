Extension { #name : #LcsApplicationEnvironmentTest }

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironmentTest >> testSuspendingCurrentSystemViaApplicationEnvironment [
	| system |
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	system := subject currentSystem.
	self assert: system isInActiveStatus.
	
	subject suspendCurrentSystem.
	
	self assert: subject currentSystem isNil.
	self assert: system isInSuspendedStatus
]
