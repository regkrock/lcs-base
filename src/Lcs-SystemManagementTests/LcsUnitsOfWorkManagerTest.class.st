Class {
	#name : #LcsUnitsOfWorkManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsUnitsOfWorkManagerTest >> testCreation [
	| unitsOfWorkManager |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.
	
	unitsOfWorkManager := LcsApplicationEnvironment unitsOfWorkManager.
	self assert: (unitsOfWorkManager isKindOf: LcsUnitsOfWorkManager).
	self assert: unitsOfWorkManager notNil

]

{ #category : #accessing }
LcsUnitsOfWorkManagerTest >> testRemoveCurrentUnitOfWork [
	| unitOfWork |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.
	
	unitOfWork := LcsApplicationEnvironment createUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork identicalTo: unitOfWork.
	self assert: LcsApplicationEnvironment unitsOfWorkManager unitsOfWork size = 1.
	
	LcsApplicationEnvironment removeCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork identicalTo:nil.
	self assert: LcsApplicationEnvironment unitsOfWorkManager unitsOfWork isEmpty
]
