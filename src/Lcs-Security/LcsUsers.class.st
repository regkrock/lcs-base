Class {
	#name : 'LcsUsers',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'query' }
LcsUsers >> guestUser [
	^ self collection detect: [ :each | each class = LcsGuestUser ] ifNone: [ LcsGuestUser new ] 
]

{ #category : 'query' }
LcsUsers >> superUser [
	^ self collection detect: [ :each | each class = LcsSuperUser ] ifNone: [ LcsSuperUser new ] 
]

{ #category : 'queries' }
LcsUsers >> userWithUuid: aUserUuid [
	^ self find: [ :each | each uuid = aUserUuid ] ifNone: [ LcsError signal: 'No User found for userUuid' ]
]
