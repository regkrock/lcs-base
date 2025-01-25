Class {
	#name : #LcsUnitsOfWorkManagerTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests-Tests'
}

{ #category : #accessing }
LcsUnitsOfWorkManagerTest >> testCreation [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	subject := LcsApplicationEnvironment unitsOfWorkManager.
	self assert: (subject isKindOf: LcsUnitsOfWorkManager).
	self assert: subject notNil.
	self assert: subject currentUnitOfWork isNil.
	self deny: subject hasCurrentUnitOfWork.
	self assert: subject unitsOfWork isEmpty.
	self assert: subject parent == LcsApplicationEnvironment singleton.
	self assert: subject numberOfUnitsOfWork equals: 0

]

{ #category : #accessing }
LcsUnitsOfWorkManagerTest >> testRemoveCurrentUnitOfWork [
	| unitOfWork |
	LcsApplicationEnvironment initializeApplicationEnvironment.

	subject := LcsApplicationEnvironment unitsOfWorkManager.
	self assert: subject numberOfUnitsOfWork equals: 0.
	unitOfWork := subject createUnitOfWork.
	self assert: subject currentUnitOfWork identicalTo: unitOfWork.
	self assert: subject numberOfUnitsOfWork equals: 1.
	subject removeCurrentUnitOfWork.
	self assert: subject currentUnitOfWork identicalTo:nil.
	self assert: subject unitsOfWork isEmpty
]
