Class {
	#name : 'LcsCommittees',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'organization model' }
LcsCommittees >> internalOrganization [
	^ self parent internalOrganization
]
