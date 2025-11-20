Class {
	#name : 'LcsOrganizations',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'querying' }
LcsOrganizations >> findWithFullName: aString [
	self find: [ :each | each fullName = aString ] ifNone: [ ^ OrderedCollection new ]
]
