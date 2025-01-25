Extension { #name : #LcsApplicationEnvironmentTest }

{ #category : #'*Lcs-PrototypeSystem' }
LcsApplicationEnvironmentTest >> testAddingSystenToApplicationEnvironment [
	subject := LcsApplicationEnvironment.
	subject initializeApplicationEnvironment.
	self assert: subject systemManager numberOfSystems equals: 0.
	subject createCurrentSystemFor: LxxPrototypeSystem.
	self assert: subject systemManager numberOfSystems equals: 1.
	self assert: subject currentSystem class identicalTo: LxxPrototypeSystem.
	self assert: subject unitsOfWorkManager numberOfUnitsOfWork equals: 1.
	self assert: subject currentUnitOfWork class identicalTo: LcsUnitOfWork.
	self assert: subject hasCurrentSystem.
	self assert: subject hasCurrentUnitOfWork.
]
