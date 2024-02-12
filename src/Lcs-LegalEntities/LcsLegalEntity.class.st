Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'entityName'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self getValueOfSlotNamed: #entityName  
]

{ #category : #accessing }
LcsLegalEntity >> entityName: aString [ 
	self setValueOfSlotNamed: #entityName to: aString
]
