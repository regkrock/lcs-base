Class {
	#name : #LcsSystemManagerTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests-Tests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testAccessingApplicationEnvironment [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment systemManager applicationEnvironment equals:  LcsApplicationEnvironment singleton.
]

{ #category : #tests }
LcsSystemManagerTest >> testAccessingUnitOfWorkManager [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	subject := LcsApplicationEnvironment systemManager.
	self assert: subject unitsOfWorkManager == LcsApplicationEnvironment unitsOfWorkManager
]

{ #category : #accessing }
LcsSystemManagerTest >> testCreateUnitOfWork [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

		LcsApplicationEnvironment createUnitOfWork.
	self assert: LcsApplicationEnvironment currentUnitOfWork class identicalTo: LcsUnitOfWork 
]

{ #category : #tests }
LcsSystemManagerTest >> testRemoveCurrentSystem [
	LcsApplicationEnvironment initializeApplicationEnvironment.

	LcsApplicationEnvironment currentSystem: 'example'.
	self assert: LcsApplicationEnvironment currentSystem equals: 'example'.
	
	LcsApplicationEnvironment removeCurrentSystem.
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self assert: LcsApplicationEnvironment currentUnitOfWork isNil.

]

{ #category : #accessing }
LcsSystemManagerTest >> testRemoveCurrentUnitOfWork [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	subject := LcsApplicationEnvironment unitsOfWorkManager.
	self deny: subject hasCurrentUnitOfWork.
	
	subject createUnitOfWorkForCurrentSystem.
	self assert: subject hasCurrentUnitOfWork.
	
	subject removeCurrentUnitOfWork.
	self deny: subject hasCurrentUnitOfWork
]

{ #category : #tests }
LcsSystemManagerTest >> testSystemMangerAPIsWhenCollectionIsEmpty [
	LcsApplicationEnvironment initializeApplicationEnvironment.
	subject := LcsApplicationEnvironment systemManager.
	
	self assert: subject parent equals: LcsApplicationEnvironment singleton.
	self assert: subject numberOfSystems equals: 0.
	self assert:subject currentSystem isNil.
	self assert: subject systems isEmpty.
	subject removeCurrentSystem.
	self assert: subject numberOfSystems equals: 0.
	subject suspendCurrentSystem.
	self assert: subject numberOfSystems equals: 0.
	subject releaseApplicationEnvironment.
	self assert: subject numberOfSystems equals: 0.
	self assert:subject currentUnitOfWork isNil.
	self assert: subject hasNoSystems.
	self deny: subject hasSystems.
	self assert: subject hasNoCurrentSystem.
	self deny: subject hasCurrentSystem
]
