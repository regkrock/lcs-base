Class {
	#name : #LcsUsers,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Security-Core'
}

{ #category : #query }
LcsUsers >> guestUser [
	^ self collection detect: [ :each | each class = LcsGuestUser ] ifNone: [ LcsGuestUser new ] 
]

{ #category : #query }
LcsUsers >> superUser [
	^ self collection detect: [ :each | each class = LcsSuperUser ] ifNone: [ LcsSuperUser new ] 
]

{ #category : #queries }
LcsUsers >> userWithUuid: aUserUuid [
	^ self collection detect: [ :each | each userUuid = aUserUuid ] ifNone: [ LcsError signal: 'No User found for userUuid' ]
]
