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

{ #category : #'as yet unclassified' }
LcsCodes >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items' translated;
		priority: 0.5;
		items: [ self collection asOrderedCollection ];
		column: 'code' text: [ :each | each code ];
		column: 'description' text: [ :each | each description ];
		column: 'Label' text: [ :each | each label ];
		column: 'Is Default' text: [ :each | each isDefaultInstance ifTrue: [ 'Yes' ] ifFalse: [ '' ] ];
		actionUpdateButton
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
