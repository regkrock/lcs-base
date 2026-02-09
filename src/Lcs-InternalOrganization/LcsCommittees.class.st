Class {
	#name : 'LcsCommittees',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'querying' }
LcsCommittees >> findWithOrganizationName: aName [
	^ self find: [ :each | each organizationName = aName ]
]

{ #category : 'organization model' }
LcsCommittees >> internalOrganization [
	^ self parent internalOrganization
]
