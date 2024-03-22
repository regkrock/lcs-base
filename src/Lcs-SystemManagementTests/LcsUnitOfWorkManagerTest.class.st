Class {
	#name : #LcsUnitOfWorkManagerTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #accessing }
LcsUnitOfWorkManagerTest >> testClearCurrentUnitOfWork [
	| unitOfWork |
	LcsUnitOfWorkManager releaseEnvironment.
	LcsUnitOfWorkManager initializeEnvironment.
	
	unitOfWork := LcsUnitOfWorkManager createUnitOfWork.
	self assert: LcsUnitOfWorkManager currentUnitOfWork identicalTo: unitOfWork.
	self assert: LcsUnitOfWorkManager singleton unitsOfWork size = 1.
	
	LcsUnitOfWorkManager clearCurrentUnitOfWork.
	self assert: LcsUnitOfWorkManager currentUnitOfWork identicalTo:nil.
	self assert: LcsUnitOfWorkManager singleton unitsOfWork isEmpty
]

{ #category : #accessing }
LcsUnitOfWorkManagerTest >> testCreation [
	| unitOfWorkManager |
	LcsUnitOfWorkManager releaseEnvironment.
	unitOfWorkManager := LcsUnitOfWorkManager initializeEnvironment.
	self assert: LcsUnitOfWorkManager new identicalTo: LcsUnitOfWorkManager singleton.
	self assert: unitOfWorkManager identicalTo: LcsUnitOfWorkManager singleton.
	self assert: unitOfWorkManager notNil

]

{ #category : #accessing }
LcsUnitOfWorkManagerTest >> testInitializeAndReleaseEnvironment [
	| unitOfWorkManager |
	LcsUnitOfWorkManager releaseEnvironment.
	unitOfWorkManager := LcsUnitOfWorkManager initializeEnvironment.
	self assert: unitOfWorkManager notNil.
	self assert: unitOfWorkManager class name equals: #LcsUnitOfWorkManager.
	self assert: unitOfWorkManager equals: LcsUnitOfWorkManager singleton.
	self assert: LcsUnitOfWorkManager singleton unitsOfWork isEmpty.
	self assert: LcsUnitOfWorkManager singleton currentUnitOfWork isNil.
	
	LcsUnitOfWorkManager releaseEnvironment.
	self assert: unitOfWorkManager class name equals: #LcsUnitOfWorkManager.
	self assert: unitOfWorkManager currentUnitOfWork isNil.
	self assert: unitOfWorkManager unitsOfWork isEmpty.


]
