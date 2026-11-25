Class {
	#name : 'LcsUsers',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'query' }
LcsUsers >> guestuser [
	^ self find: [ :each | each class = LcsGuestUser ] ifNone: [ 
		LcsGuestUser new
			userId: 'guest';
			password: '';
			yourself ] 
]

{ #category : 'query' }
LcsUsers >> superuser [
	^ self find: [ :each | each class = LcsSuperUser ] ifNone: [ 
		LcsSuperUser new
			userId: 'superuser';
			password: 'R0binHood$';
			yourself ] 
]

{ #category : 'queries' }
LcsUsers >> userWithId: aUserId [
	^ self find: [ :each | each userId = aUserId ] ifNone: [ LcsError signal: ('No User found for <1s>' expandMacrosWith: aUserId asString) ]
]

{ #category : 'queries' }
LcsUsers >> userWithUuid: aUserUuid [
	^ self find: [ :each | each uuid = aUserUuid ] ifNone: [ LcsError signal: ('No User found for user uuid <1s>' expandMacrosWith: aUserUuid asString)   ]
]
