Class {
	#name : #LcsOrganization,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'location'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsOrganization >> location [
	^ self getValueOfSlotNamed: 'location'
]

{ #category : #accessing }
LcsOrganization >> location: anObject [
	self setValueOfSlotNamed: 'location' to: anObject
]
