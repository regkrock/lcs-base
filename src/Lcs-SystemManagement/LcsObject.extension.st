Extension { #name : #LcsObject }

{ #category : #'*Lcs-SystemManagement' }
LcsObject class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'*Lcs-SystemManagement' }
LcsObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #'*Lcs-SystemManagement' }
LcsObject >> currentUnitOfWork [
	^ self class currentUnitOfWork
]

{ #category : #'*Lcs-SystemManagement' }
LcsObject class >> currentUnitOfWork [
	^ self currentSystem ifNotNil: [:system | system currentUnitOfWork ]
]
