Class {
	#name : #LcsSystemManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testClearCurrentSystem [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	self assert: LcsSystemManager currentSystem isNil.
	self assert: LcsSystemManager currentUnitOfWork isNil.

	LcsSystemManager currentSystem: 'example'.
	self assert: LcsSystemManager currentSystem = 'example'.
	
	LcsSystemManager removeCurrentSystem.
	self assert: LcsSystemManager currentSystem isNil.
	self assert: LcsSystemManager currentUnitOfWork isNil.

]

{ #category : #accessing }
LcsSystemManagerTest >> testClearCurrentUnitOfWork [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	LcsUnitOfWorkManager clearCurrentUnitOfWork.
	self assert: LcsSystemManager currentUnitOfWork isNil
]

{ #category : #accessing }
LcsSystemManagerTest >> testCreateUnitOfWork [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	self assert: LcsSystemManager currentUnitOfWork isNil.
	LcsSystemManager createUnitOfWork.
	self assert: LcsSystemManager currentUnitOfWork class identicalTo: LcsUnitOfWork 
]
