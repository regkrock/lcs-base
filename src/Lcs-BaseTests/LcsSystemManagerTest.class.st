Class {
	#name : #LcsSystemManagerTest,
	#superclass : #TestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #accessing }
LcsSystemManagerTest >> testClearCurrentSystem [
	LcsSystemManager clearCurrentSystem.
	self assert: LcsSystemManager currentSystem isNil.
	self assert: LcsSystemManager currentUnitOfWork isNil.
	
	LcsSystemManager currentSystem: 'example'.
	self assert: LcsSystemManager currentSystem = 'example'.
]
