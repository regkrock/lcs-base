Trait {
	#name : #LtApplicationEnvironment,
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'application environment' }
LtApplicationEnvironment classSide >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LtApplicationEnvironment classSide >> currentUnitOfWork [
	^ self currentSystem ifNotNil: [:system | system currentUnitOfWork ]
]

{ #category : #'application environment' }
LtApplicationEnvironment >> currentSystem [
	^ self class currentSystem
]

{ #category : #'application environment' }
LtApplicationEnvironment >> currentUnitOfWork [
	^ self class currentUnitOfWork
]
