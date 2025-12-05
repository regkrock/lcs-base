Class {
	#name : 'LcsCommitteeMembers',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'querying' }
LcsCommitteeMembers >> defaultInstance [
	^ self
		find: [ :each | each class name = LcsUnknownCommitteeMember name ]
		ifNone: [ 
			self add: 
				LcsUnknownCommitteeMember new ]
]

{ #category : 'organization model' }
LcsCommitteeMembers >> internalOrganization [
	^ self parent internalOrganization
]
