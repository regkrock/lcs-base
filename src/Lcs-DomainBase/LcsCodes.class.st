Class {
	#name : #LcsCodes,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #testing }
LcsCodes >> collectionWithPendingChanges [
	| actualCollection |
	actualCollection := self collection copy.
	actualCollection addAll: self pendingAdds.
	actualCollection removeAll: self pendingDeletes.
	^ actualCollection
]

{ #category : #testing }
LcsCodes >> defaultInstance [
	^ self collectionWithPendingChanges
		detect: [ :each | each isDefaultInstance == true ]
		ifNone: [ LcsCodeCollectionDefaultInstanceNotDefined
				signal: 'No default instance defined for codes collection - ' , self class name ]
]

{ #category : #testing }
LcsCodes >> hasDefaultInstance [
	self collection detect: [ :each | each isDefaultInstance == true] ifNone: [ ^ false ].
	^ true
]

{ #category : #testing }
LcsCodes >> hasUnknownInstance [
	self collection detect: [ :each | each code = 'unknown'] ifNone: [ ^ false ].
	^ true
]
