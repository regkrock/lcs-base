Class {
	#name : #LcsSystemManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testCreateUnitOfWork [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.
	LcsApplicationEnvironment createUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork class identicalTo: LcsUnitOfWork 
]

{ #category : #tests }
LcsSystemManagerTest >> testRemoveCurrentSystem [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

	LcsApplicationEnvironment currentSystem: 'example'.
	self assert: LcsApplicationEnvironment currentSystem equals: 'example'.
	
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

]

{ #category : #accessing }
LcsSystemManagerTest >> testRemoveCurrentUnitOfWork [
	LcsApplicationEnvironment releaseEnvironment.
	LcsApplicationEnvironment initializeEnvironment.

	LcsApplicationEnvironment removeCurrentUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil
]
