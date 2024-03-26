Class {
	#name : #LcsUnitOfWorkManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsUnitOfWorkManagerTest >> testClearCurrentUnitOfWork [
	| unitOfWork |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.
	
	unitOfWork := LcsUnitOfWorkManager createUnitOfWork.
	self assert: LcsUnitOfWorkManager currentUnitOfWork identicalTo: unitOfWork.
	self assert: LcsApplicationEnvironment unitOfWorkManager unitsOfWork size = 1.
	
	LcsUnitOfWorkManager clearCurrentUnitOfWork.
	self assert: LcsUnitOfWorkManager currentUnitOfWork identicalTo:nil.
	self assert: LcsApplicationEnvironment unitOfWorkManager unitsOfWork isEmpty
]

{ #category : #accessing }
LcsUnitOfWorkManagerTest >> testCreation [
	| unitOfWorkManager |
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.
	
	unitOfWorkManager := LcsUnitOfWorkManager new.
	self assert: unitOfWorkManager identicalTo: LcsApplicationEnvironment currentApplicationEnvironment unitOfWorkManager.
	self assert: unitOfWorkManager notNil

]
