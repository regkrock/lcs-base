Class {
	#name : #LcsDeletedObjectRecord,
	#superclass : #LcsObjectChangeRecord,
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsDeletedObjectRecord >> applyChanges [

	self error: 'Needs to be implemented'
]
