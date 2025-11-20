Class {
	#name : 'LcsBaseDomainCollection',
	#superclass : 'LcsDomainObject',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'querrying' }
LcsBaseDomainCollection >> collectionType [
	^ self class collectionType
]

{ #category : 'querying' }
LcsBaseDomainCollection >> find: aBlock [
	^ self find: aBlock ifNone: [ nil ]
]

{ #category : 'querying' }
LcsBaseDomainCollection >> findWithKey: anObject [
	^ self findWithKey: anObject ifNone: [ ]
]
