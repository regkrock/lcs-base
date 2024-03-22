Class {
	#name : #LcsSystemManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testClearCurrentSystem [
	LcsSystemManager releaseEnvironment.
	LcsSystemManager initializeEnvironment.
	self assert: LcsSystemManager currentSystem isNil.
	self assert: LcsSystemManager currentUnitOfWork isNil.
	LcsSystemManager currentSystem: 'example'.
	self assert: LcsSystemManager currentSystem = 'example'.
	
	LcsSystemManager clearCurrentSystem.
	self assert: LcsSystemManager currentSystem isNil.
	self assert: LcsSystemManager currentUnitOfWork isNil.

]

{ #category : #accessing }
LcsSystemManagerTest >> testClearCurrentUnitOfWork [
	LcsSystemManager releaseEnvironment.
	LcsSystemManager initializeEnvironment.
	LcsUnitOfWorkManager clearCurrentUnitOfWork.
	self assert: LcsSystemManager currentUnitOfWork isNil
]

{ #category : #accessing }
LcsSystemManagerTest >> testCreateUnitOfWork [
	LcsSystemManager releaseEnvironment.
	LcsSystemManager initializeEnvironment.
	self assert: LcsSystemManager currentUnitOfWork isNil.
	LcsSystemManager createUnitOfWork.
	self assert: LcsSystemManager currentUnitOfWork class identicalTo: LcsUnitOfWork 
]

{ #category : #accessing }
LcsSystemManagerTest >> testInitializeEvnironment [
	LcsSystemManager releaseEnvironment.
	self assert: LcsSystemManager singleton isNil.
	self assert: LcsUnitOfWorkManager singleton isNil.
	LcsSystemManager initializeEnvironment.
	self assert: LcsSystemManager singleton notNil.
	self assert: LcsUnitOfWorkManager notNil.
	
	LcsSystemManager releaseEnvironment.
	self assert: LcsSystemManager singleton isNil.
	self assert: LcsUnitOfWorkManager singleton isNil.

]
